require "fdis2/version"
require "fdis2/config"
require "fdis2/facturacion"

require 'openssl'
require 'net/http'
require 'base64'
require 'json'
require 'securerandom'
require 'fileutils'

# External gems
require 'nokogiri'

module Fdis2

end


# example
# @sw = Fdis2::Facturacion.new(
#   "PAMA891110MP9",
#   sat.rfc,
#   sat.razon,
#   sat.regimen_fiscal,
#   ActiveStorage::Blob.service.path_for(sat.key_archive.key),
#   sat.key_pass,
#   ActiveStorage::Blob.service.path_for(sat.cer_archive.key),
#   Rails.env.production?
# )