module ClubsHelper
  def placeholder_subdomain(name)
    name.to_s.downcase.remove(' ').remove(/\W+/).remove('hackclub').remove('high').remove('school')
  end

  def map_url(lat, lng, options = {})
    "https://api.mapbox.com/styles/v1/mapbox/satellite-v9/static/#{lng},#{lat},5,0,24/1280x1280@2x?access_token=pk.eyJ1IjoiaGFja2NsdWIiLCJhIjoiY2pscGI1eGdhMGRyNzN3bnZvbGY5NDBvZSJ9.Zm4Zduj94TrgU8h890M7gA"
  end
end
