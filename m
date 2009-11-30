From: Sven Anders <anders-3bOZC6EutKuELgA04lAiVw@public.gmane.org>
Subject: Need help: Watchdog-driver over smbus (i2c)
Date: Mon, 30 Nov 2009 22:30:07 +0100
Message-ID: <4B14395F.4070608@anduras.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms000803000209050207040100"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000803000209050207040100
Content-Type: multipart/mixed;
 boundary="------------020300010900000204070103"

This is a multi-part message in MIME format.
--------------020300010900000204070103
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello!

I'm trying to code a watchdog driver for the Winbond w83793g chip. I
already coded a watchdog for another Winbond chip before, but for
this I need to access it over the system managment bus (or more
specific the i2c, client address 2E).

I already coded the detection and initialization routines, but now I
need some help, because I do not know how to use the i2c framework
together with the watchdog framework.
All other drivers I found are using the sysfs framework. This functions
use the to_i2c_client() function to get a pointer to the i2c client.

I tried to store the i2c client pointer to a global variable, to use
it later in the watchdog functions.
But when I try to use the "i2c_smbus_read_byte_data()" or
"i2c_smbus_write_byte_data()" functions, I will get a kernel OOPS
(without any hw-sensors driver loaded!).

What is the best method to get the watchdog framework (i.e. the open,
close, write, read and ioctl functions) to work with the i2c framework?


Moreover the w83793g hardware sensors driver may already
accessing the same chip. What is the normal way to deal with this?


Regards
 Sven Anders

-- 
 Sven Anders <anders-3bOZC6EutKuELgA04lAiVw@public.gmane.org>                 () Ascii Ribbon Campaign
                                                 /\ Support plain text e-mail
 ANDURAS service solutions AG
 Innstrasse 71 - 94036 Passau - Germany
 Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 50-55

Those who would give up essential Liberty, to purchase a little
temporary Safety, deserve neither Liberty nor Safety.
  - Benjamin Franklin

--------------020300010900000204070103
Content-Type: text/x-vcard; charset=utf-8;
 name="anders.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="anders.vcf"

begin:vcard
fn:Sven Anders
n:Anders;Sven
org:ANDURAS AG;Research and Development
adr;quoted-printable:;;Innstra=C3=9Fe 71;Passau;Bavaria;94036;Germany
email;internet:anders-3bOZC6EutKuELgA04lAiVw@public.gmane.org
title:Dipl. Inf.
tel;work:++49 (0)851 / 490 50 -0
tel;fax:++49 (0)851 / 590 50 - 55
x-mozilla-html:FALSE
url:http://www.anduras.de
version:2.1
end:vcard


--------------020300010900000204070103--

--------------ms000803000209050207040100
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOsDCC
B1QwggU8oAMCAQICAxAABTANBgkqhkiG9w0BAQUFADCBqjELMAkGA1UEBhMCREUxCzAJBgNV
BAgTAkJZMQ8wDQYDVQQHEwZQYXNzYXUxEzARBgNVBAoTCkFORFVSQVMgQUcxHjAcBgNVBAsT
FUNlcnRpZmljYXRlIEF1dGhvcml0eTEpMCcGA1UEAxMgQU5EVVJBUyBBRyBDZXJ0aWZpY2F0
ZSBBdXRob3JpdHkxHTAbBgkqhkiG9w0BCQEWDnBraUBhbmR1cmFzLmRlMB4XDTA5MTAyMDIw
MzQ1N1oXDTE0MTAyMDIwMzQ1N1owgbAxCzAJBgNVBAYTAkRFMQswCQYDVQQIEwJCWTEPMA0G
A1UEBxMGUGFzc2F1MRMwEQYDVQQKEwpBTkRVUkFTIEFHMSkwJwYDVQQKEyBmOTIyMjlhOWM5
MjBiOGVkZGEwYzRlYzg4MGQ4ZTgzYjELMAkGA1UECxMCR0wxFDASBgNVBAMTC3N2ZW4uYW5k
ZXJzMSAwHgYJKoZIhvcNAQkBFhFhbmRlcnNAYW5kdXJhcy5kZTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBALxbO8bh1hRSEsTu7n/7sPpS7fHqLeQWzwg1mengwU8V1xK3nfB5
gA/LyZDo96CDnhlnizlaSXRHCjVOVGO7IiM/GWhRFhSXBz1uqv0FHffkC1xI0T1C9ySSDp4R
RgKry3PiR79wS9E2fzKjqctNZIld3blaGBHmElRSEjHuxOiyR/k0I1YndkLrJA/n4UsLzoEF
qGNJ49EDRucUEL1bBCjT8ZiCiPrQiBSfk2K5BPtqg68I+BQMjIAVmhpvxv5UQcrKWKFoeWyF
JqgJb4+gioDlDuTYUxDjurdU6+dI+I011vS/rj5qe81DcXNiQA55NqTgDQrsJCyj+H0qMZW2
lk0CAwEAAaOCAnkwggJ1MAwGA1UdEwEB/wQCMAAwDgYDVR0PAQH/BAQDAgP4MCoGA1UdJQQj
MCEGCCsGAQUFBwMEBggrBgEFBQcDAgYLKwYBBAGB6y0DAQEwFAYJYIZIAYb4QgEBAQH/BAQD
AgWgMB0GA1UdDgQWBBT1nf148Ot7Zwor+h/kFKOzgPoJPzCB3wYDVR0jBIHXMIHUgBQ34zit
047U9ZuPSA8TE9kjVMkm96GBsKSBrTCBqjELMAkGA1UEBhMCREUxCzAJBgNVBAgTAkJZMQ8w
DQYDVQQHEwZQYXNzYXUxEzARBgNVBAoTCkFORFVSQVMgQUcxHjAcBgNVBAsTFUNlcnRpZmlj
YXRlIEF1dGhvcml0eTEpMCcGA1UEAxMgQU5EVVJBUyBBRyBDZXJ0aWZpY2F0ZSBBdXRob3Jp
dHkxHTAbBgkqhkiG9w0BCQEWDnBraUBhbmR1cmFzLmRlggkAhNxpBFvYvqIwGQYDVR0SBBIw
EIEOcGtpQGFuZHVyYXMuZGUwYAYDVR0fBFkwVzApoCegJYYjaHR0cDovL2NhLmFuZHVyYXMu
ZGUvYW5kdXJhcy1jYS5jcmwwKqAooCaGJGh0dHA6Ly9jcmwuYW5kdXJhcy5kZS9hbmR1cmFz
LWNhLmNybDAuBglghkgBhvhCAQ0EIRYfQU5EVVJBUyBBRyBQZXJzb25hbCBDZXJ0aWZpY2F0
ZTBlBggrBgEFBQcBAQRZMFcwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLmFuZHVyYXMuZGUv
MDAGCCsGAQUFBzAChiRodHRwOi8vY2EuYW5kdXJhcy5kZS9hbmR1cmFzLWNhLmh0bWwwDQYJ
KoZIhvcNAQEFBQADggIBAD7x+V+hQ00k19ISJgTDzupxFpAnOugXe2sgM9zmdx+RlsAJ56mB
nvdhoTtlwi2wCUV1jW848w024TJ+xW5kOrU5RzpWc+8lrOhakcs4VYgaYez+fSXOk/t1gAxV
haFglg5mfdj5XZvKs8NnvlkKZioWWbKVW6S404HGNn5pOwxRnT+1SaSpSWxWbng0XC6BZuP4
FkxnKD9yCWcKDbfkIYk3CQFAlVMB6jZNffiScf9SVHkwytnw+Op0LwvEaK9oSJ+9KxPKYbkG
V4DP3bDujeI448gUZExT/FH501eaWr0U3P6I88Omru6UwVZnIx+cJgUmNGr0RoyPMuD5KAX6
1cvDukeJVLhT3uUChsl3huWQkUVH6kvPqNyG+PM1LnhGk0LGGQvk5NMMHDFl9Su+9SRIh8BA
xb8dbIUEorXKgYoxNWGdv/0qpcik7pUOygqSdYOleIqlUVUG53KtwVhrOvZEpu3kSldTm5m2
z16VD4AIediBB5AxpyWVF3OXyGLrsKWofydZrrMdu+l0GNKPC2NVFGlXt3U49b+nvsW4TSBP
IbIkTmbQwbbj0jXVrBfzx95zHsaq7152Y+857Fm9NSSws1nEBvMBSVmCsRtM00tqZedVZzZG
VFKHByO2+xsG0QSksVA0VGIDczgpmjJBVm2UkO66/ZBwQ/mm6u3wMx4OMIIHVDCCBTygAwIB
AgIDEAAFMA0GCSqGSIb3DQEBBQUAMIGqMQswCQYDVQQGEwJERTELMAkGA1UECBMCQlkxDzAN
BgNVBAcTBlBhc3NhdTETMBEGA1UEChMKQU5EVVJBUyBBRzEeMBwGA1UECxMVQ2VydGlmaWNh
dGUgQXV0aG9yaXR5MSkwJwYDVQQDEyBBTkRVUkFTIEFHIENlcnRpZmljYXRlIEF1dGhvcml0
eTEdMBsGCSqGSIb3DQEJARYOcGtpQGFuZHVyYXMuZGUwHhcNMDkxMDIwMjAzNDU3WhcNMTQx
MDIwMjAzNDU3WjCBsDELMAkGA1UEBhMCREUxCzAJBgNVBAgTAkJZMQ8wDQYDVQQHEwZQYXNz
YXUxEzARBgNVBAoTCkFORFVSQVMgQUcxKTAnBgNVBAoTIGY5MjIyOWE5YzkyMGI4ZWRkYTBj
NGVjODgwZDhlODNiMQswCQYDVQQLEwJHTDEUMBIGA1UEAxMLc3Zlbi5hbmRlcnMxIDAeBgkq
hkiG9w0BCQEWEWFuZGVyc0BhbmR1cmFzLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAvFs7xuHWFFISxO7uf/uw+lLt8eot5BbPCDWZ6eDBTxXXEred8HmAD8vJkOj3oIOe
GWeLOVpJdEcKNU5UY7siIz8ZaFEWFJcHPW6q/QUd9+QLXEjRPUL3JJIOnhFGAqvLc+JHv3BL
0TZ/MqOpy01kiV3duVoYEeYSVFISMe7E6LJH+TQjVid2QuskD+fhSwvOgQWoY0nj0QNG5xQQ
vVsEKNPxmIKI+tCIFJ+TYrkE+2qDrwj4FAyMgBWaGm/G/lRByspYoWh5bIUmqAlvj6CKgOUO
5NhTEOO6t1Tr50j4jTXW9L+uPmp7zUNxc2JADnk2pOANCuwkLKP4fSoxlbaWTQIDAQABo4IC
eTCCAnUwDAYDVR0TAQH/BAIwADAOBgNVHQ8BAf8EBAMCA/gwKgYDVR0lBCMwIQYIKwYBBQUH
AwQGCCsGAQUFBwMCBgsrBgEEAYHrLQMBATAUBglghkgBhvhCAQEBAf8EBAMCBaAwHQYDVR0O
BBYEFPWd/Xjw63tnCiv6H+QUo7OA+gk/MIHfBgNVHSMEgdcwgdSAFDfjOK3TjtT1m49IDxMT
2SNUySb3oYGwpIGtMIGqMQswCQYDVQQGEwJERTELMAkGA1UECBMCQlkxDzANBgNVBAcTBlBh
c3NhdTETMBEGA1UEChMKQU5EVVJBUyBBRzEeMBwGA1UECxMVQ2VydGlmaWNhdGUgQXV0aG9y
aXR5MSkwJwYDVQQDEyBBTkRVUkFTIEFHIENlcnRpZmljYXRlIEF1dGhvcml0eTEdMBsGCSqG
SIb3DQEJARYOcGtpQGFuZHVyYXMuZGWCCQCE3GkEW9i+ojAZBgNVHRIEEjAQgQ5wa2lAYW5k
dXJhcy5kZTBgBgNVHR8EWTBXMCmgJ6AlhiNodHRwOi8vY2EuYW5kdXJhcy5kZS9hbmR1cmFz
LWNhLmNybDAqoCigJoYkaHR0cDovL2NybC5hbmR1cmFzLmRlL2FuZHVyYXMtY2EuY3JsMC4G
CWCGSAGG+EIBDQQhFh9BTkRVUkFTIEFHIFBlcnNvbmFsIENlcnRpZmljYXRlMGUGCCsGAQUF
BwEBBFkwVzAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuYW5kdXJhcy5kZS8wMAYIKwYBBQUH
MAKGJGh0dHA6Ly9jYS5hbmR1cmFzLmRlL2FuZHVyYXMtY2EuaHRtbDANBgkqhkiG9w0BAQUF
AAOCAgEAPvH5X6FDTSTX0hImBMPO6nEWkCc66Bd7ayAz3OZ3H5GWwAnnqYGe92GhO2XCLbAJ
RXWNbzjzDTbhMn7FbmQ6tTlHOlZz7yWs6FqRyzhViBph7P59Jc6T+3WADFWFoWCWDmZ92Pld
m8qzw2e+WQpmKhZZspVbpLjTgcY2fmk7DFGdP7VJpKlJbFZueDRcLoFm4/gWTGcoP3IJZwoN
t+QhiTcJAUCVUwHqNk19+JJx/1JUeTDK2fD46nQvC8Ror2hIn70rE8phuQZXgM/dsO6N4jjj
yBRkTFP8UfnTV5pavRTc/ojzw6au7pTBVmcjH5wmBSY0avRGjI8y4PkoBfrVy8O6R4lUuFPe
5QKGyXeG5ZCRRUfqS8+o3Ib48zUueEaTQsYZC+Tk0wwcMWX1K771JEiHwEDFvx1shQSitcqB
ijE1YZ2//SqlyKTulQ7KCpJ1g6V4iqVRVQbncq3BWGs69kSm7eRKV1ObmbbPXpUPgAh52IEH
kDGnJZUXc5fIYuuwpah/J1musx276XQY0o8LY1UUaVe3dTj1v6e+xbhNIE8hsiROZtDBtuPS
NdWsF/PH3nMexqrvXnZj7znsWb01JLCzWcQG8wFJWYKxG0zTS2pl51VnNkZUUocHI7b7GwbR
BKSxUDRUYgNzOCmaMkFWbZSQ7rr9kHBD+abq7fAzHg4xggQqMIIEJgIBATCBsjCBqjELMAkG
A1UEBhMCREUxCzAJBgNVBAgTAkJZMQ8wDQYDVQQHEwZQYXNzYXUxEzARBgNVBAoTCkFORFVS
QVMgQUcxHjAcBgNVBAsTFUNlcnRpZmljYXRlIEF1dGhvcml0eTEpMCcGA1UEAxMgQU5EVVJB
UyBBRyBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkxHTAbBgkqhkiG9w0BCQEWDnBraUBhbmR1cmFz
LmRlAgMQAAUwCQYFKw4DAhoFAKCCAkwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMDkxMTMwMjEzMDA3WjAjBgkqhkiG9w0BCQQxFgQUKh+9PAGrJjoh0xqW
sWSvJOnlwnswXwYJKoZIhvcNAQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYI
KoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIHD
BgkrBgEEAYI3EAQxgbUwgbIwgaoxCzAJBgNVBAYTAkRFMQswCQYDVQQIEwJCWTEPMA0GA1UE
BxMGUGFzc2F1MRMwEQYDVQQKEwpBTkRVUkFTIEFHMR4wHAYDVQQLExVDZXJ0aWZpY2F0ZSBB
dXRob3JpdHkxKTAnBgNVBAMTIEFORFVSQVMgQUcgQ2VydGlmaWNhdGUgQXV0aG9yaXR5MR0w
GwYJKoZIhvcNAQkBFg5wa2lAYW5kdXJhcy5kZQIDEAAFMIHFBgsqhkiG9w0BCRACCzGBtaCB
sjCBqjELMAkGA1UEBhMCREUxCzAJBgNVBAgTAkJZMQ8wDQYDVQQHEwZQYXNzYXUxEzARBgNV
BAoTCkFORFVSQVMgQUcxHjAcBgNVBAsTFUNlcnRpZmljYXRlIEF1dGhvcml0eTEpMCcGA1UE
AxMgQU5EVVJBUyBBRyBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkxHTAbBgkqhkiG9w0BCQEWDnBr
aUBhbmR1cmFzLmRlAgMQAAUwDQYJKoZIhvcNAQEBBQAEggEAuWlC81PXIKRCKoZy4A7eJ7Ti
i9JpJyr4+aXLujl///EfA5faRibJ9FdRMiOdz4XSmIbYPjPAb5LBYLtbVi9Htq/Fjk024f9j
E/rR3SW47oeu7/Se3YaQNGhY1CPr9rNUmuKbv3bNzTgYWs5S9fcy7jbI8QIQrlZsNiFeVoBs
5ZNlm64/tdcDvQXh4FsDuBVxZ2zCc2eQunuRfnwK83SivejQBauCb2I7a7PGdXSsAicyj7bb
B8aaIzw9PdTjRk9s7mh352ceW6Dv6KWxTyRzs+ek/BW4CQ+DqbUraTWT6vxtcuSPw+tH2YCw
bGq0jin8+au71LibtvgdCQg4fvmFAAAAAAAAAA==
--------------ms000803000209050207040100--
