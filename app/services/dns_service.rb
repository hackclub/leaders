class DnsService
  def self.check(type, host, expected_result)
    resolv_resource = Resolv::DNS::Resource::IN.const_get type
    resources = Resolv::DNS.new.getresources(host, resolv_resource)
    resources.any? do |resource|
      case type
      when 'A'
      when 'AAAA'
        resource.address.to_s == expected_result
      when 'CNAME'
        resource.name.to_s == expected_result
      when 'TXT'
        resource.strings.include? expected_result
      end
    end
  end
end
