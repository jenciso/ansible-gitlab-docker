external_url "https://gitlab.{{ domain_company }}/"

gitlab_rails['time_zone'] = 'America/Sao_Paulo'

nginx['client_max_body_size'] = '250m'
nginx['redirect_http_to_https'] = 'True'
nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.{{ domain_company }}.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.{{ domain_company }}.key"

gitlab_rails['ldap_enabled'] = true                                                                                                                                                                                
                                                                                                                                                                                                                   
gitlab_rails['ldap_servers'] = {
'main' => {
  'label' => 'Gitlab AD',
  'host' =>  '{{ gitlab_active_directory }}',
  'port' => 389,
  'uid' => 'sAMAccountName',
  'encryption' => 'plain',
  'verify_certificates' => false,
  'bind_dn' => 'Administrator@{{ internal_domain_company }}',
  'password' => '{{ ad_administrator_password }}',
  'active_directory' => true,
  'base' => '{{ gitlab_ldap_base }}',
  'group_base' => '{{ gitlab_ldap_group_base }}',
  'admin_group' => 'Global Admins'
  }
}

gitlab_rails['gitlab_signup_enabled'] = true

gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "relay.{{ internal_domain_company }}"
gitlab_rails['smtp_port'] = 25

registry['enable'] = true
registry_external_url 'https://gitlab.enciso.website:4567'
registry_nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.{{ domain_company }}.crt"
registry_nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.{{ domain_company }}.key"
