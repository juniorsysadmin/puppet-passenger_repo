# See the README.md for a full description of the parameters
class passenger_repo::params {
  $ensure                 = 'present'
  $enterprise_license_key = undef
  $enterprise_repo_name   = 'phusion_passenger_enterprise'
  $enterprise_token       = undef
  $key_id                 = '16378A33A6EF16762922526E561F9B9CAC40B2F7'
  $key_server             = 'keyserver.ubuntu.com'
  $oss_repo_name          = 'phusion_passenger'
  $pin                    = false
}
