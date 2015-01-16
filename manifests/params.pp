# See the README.md for a full description of the parameters
class passenger_repo::params {
  $ensure                 = 'present'
  $enterprise_license_key = undef
  $enterprise_repo_name   = 'phusion_passenger_enterprise'
  $enterprise_token       = undef
  $oss_repo_name          = 'phusion_passenger'
  $pin                    = false
}
