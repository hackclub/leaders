class ApiService
  BASE_URL = 'https://api.hackclub.com'

  def self.req(method, path, params, access_token=nil)
    conn = Faraday.new(url: BASE_URL)

    resp = conn.send(method) do |req|
      req.url path
      req.headers['Content-Type'] = 'application/json'

      if access_token
        req.headers['Authorization'] = "Bearer #{access_token}"
      end

      req.body = params.to_json
    end

    JSON.parse(resp.body, symbolize_names: true)
  end

  def self.request_login_code(email)
    req(:post, '/v1/users/auth', { email: email })
  end

  def self.exchange_login_code(user_id, login_code)
    req(:post, "/v1/users/#{user_id}/exchange_login_code", { login_code: login_code })
  end

  def self.get_user(user_id, access_token)
    req(:get, "/v1/users/#{user_id}", nil, access_token)
  end

  def self.get_clubs(leader_id, access_token)
    req(:get, "/v1/new_leaders/#{leader_id}/new_clubs", nil, access_token)
  end

  def self.get_club(club_id, access_token)
    req(:get, "/v1/new_clubs/#{club_id}", nil, access_token)
  end

  def self.update_clubs_for_user(user)
    clubs = get_clubs(user.leader[:id], user.api_access_token)
    ActiveRecord::Base.transaction do
      user.clubs = []
      club_records = clubs.map do |club|
        club_record = Club.find_or_initialize_by({api_id: club[:id]})
        club_record.name = club[:high_school_name]
        club_record.slug = club[:high_school_name].parameterize
        club_record.api_record = club
        club_record
      end
      user.clubs = club_records
      club_records.each(&:save!) && user.save!
    end
  end
end
