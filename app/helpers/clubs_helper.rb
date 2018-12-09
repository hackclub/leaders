module ClubsHelper
  def placeholder_subdomain(name)
    name.to_s.downcase.remove(' ').remove(/\W+/).remove('hackclub').remove('high').remove('school')
  end

  def map_url(lat=nil, lng=nil, options = {})
    lat ||= 41.838796
    lng ||= -83.200725
    # default lat & lng are a beautiful location I found that is used when arguments are null
    "https://dev.virtualearth.net/REST/v1/Imagery/Map/Aerial/#{lat},#{lng}/11/?mapSize=2000,1500&format=png&key=AssBchuxLMpaS6MmACdfDyLpD4X7_T2SZ34cC_KBcWlPU6iZCsWgv0tTbw5Coehm"
  end
end
