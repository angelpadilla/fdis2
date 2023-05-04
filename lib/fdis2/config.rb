module Fdis2
  class Config
    attr_accessor :production_token, :dev_token, :doc_cer_path, :doc_key_path
    attr_reader :pem, :serial, :cadena, :key_pass, :pem_cadena

    def initialize(id_servicio, rfc, razon, regimen, doc_key_path, key_pass, doc_cer_path, production=false)
		  puts "---- Fdis:config:initialize"

      @id_servicio = id_servicio.to_s
      @rfc = rfc.to_s
      @razon = razon.to_s
      @regimen_fiscal = regimen
      @doc_key_path = doc_key_path.to_s
      @key_pass = key_pass.to_s
      @doc_cer_path = doc_cer_path
      @production = production

      puts "------ Fdis: Config inicial ---"
      puts "-- id servicio: #{@id_servicio}"
      puts "-- rfc: #{@rfc}"
      puts "-- razon: #{@razon}"
      puts "-- regimen_fiscal: #{@regimen_fiscal}"
      puts "-- key_path: #{@doc_key_path}"
      puts "-- cer_path: #{@doc_cer_path}"
      puts "-- production: #{@production}"

      key_to_pem 
      serial_number 
      cer_cadena

    end

    def key_to_pem
      puts "---- Fdis:config:key_to_pem"

      @pem = %x[openssl pkcs8 -inform DER -in #{@doc_key_path} -passin pass:#{@key_pass}]
      # @pem = %x[openssl rsa -inform DER -in #{@doc_key_path} -passin pass:#{@key_pass}]
      @pem_cadena = @pem.clone
      @pem_cadena.slice!("-----BEGIN PRIVATE KEY-----")
      @pem_cadena.slice!("-----END PRIVATE KEY-----")
      @pem_cadena.delete!("\n")
    end

    def serial_number
      puts "---- Fdis:config:serial_number"

      response = %x[openssl x509 -inform DER -in #{@doc_cer_path} -noout -serial]
      d_begin = response.index(/\d/)
      number = (response[d_begin..-1]).chomp
      final_serial = ""

      number.each_char.with_index do |s, index|
        if (index + 1).even?
          final_serial << s
        end
      end

      @serial = final_serial
      
    end


    def cer_cadena
      puts "---- Fdis:config:cer_cadena"

      file = File.read(@doc_cer_path)
      text_certificate = OpenSSL::X509::Certificate.new(file)
      cert_string = text_certificate.to_s
      cert_string.slice!("-----BEGIN CERTIFICATE-----")
      cert_string.slice!("-----END CERTIFICATE-----")
      cert_string.delete!("\n")
      @cadena = cert_string

    end
    
  end


  UrlPro = "https://v4.cfdis.mx/api/Cfdi"
  UrlCancel = "https://v4.cfdis.mx/api/CfdiCancelacion/Cancelar"

  DocBase = %(<?xml version="1.0" encoding="utf-8"?>
  <cfdi:Comprobante xsi:schemaLocation="http://www.sat.gob.mx/cfd/4 http://www.sat.gob.mx/sitio_internet/cfd/4/cfdv40.xsd" Version="4.0" xmlns:cfdi="http://www.sat.gob.mx/cfd/4" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <cfdi:Emisor />
    <cfdi:Receptor />
    <cfdi:Conceptos></cfdi:Conceptos>
    <cfdi:Impuestos></cfdi:Impuestos>
  </cfdi:Comprobante>)


  Doc_concepto = %(
  <cfdi:Concepto ClaveProdServ="25172504" NoIdentificacion="COST37125R17" Cantidad="1" ClaveUnidad="H87" Unidad="Pieza" Descripcion="Producto de prueba" ValorUnitario="1000.00" Importe="1000.00">
    <cfdi:Impuestos>
      <cfdi:Traslados>
        <cfdi:Traslado Base="1000.00" Impuesto="002" TipoFactor="Tasa" TasaOCuota="0.160000" Importe="160.00" />
      </cfdi:Traslados>
    </cfdi:Impuestos>
  </cfdi:Concepto>)


end