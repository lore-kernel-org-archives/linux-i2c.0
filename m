From: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Fri, 11 Apr 2014 18:55:57 +0000
Message-ID: <1397242556.5276.39.camel@x230>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>
	 <1397061392.5276.11.camel@x230> <53457D0D.7020805@redhat.com>
	 <1397063381.5276.17.camel@x230> <5346EDEA.3070704@redhat.com>
	 <1397161609.5276.32.camel@x230> <53482AC2.2060605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53482AC2.2060605-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <AA2B478A8E7E3942914CF9728C90D684-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

T24gRnJpLCAyMDE0LTA0LTExIGF0IDEzOjQ3IC0wNDAwLCBQcmFyaXQgQmhhcmdhdmEgd3JvdGU6
DQoNCj4gSSB0aGluayBJIG1pc3NlZCBzb21ldGhpbmcgaW4gdGhpcyBleGFtcGxlIChhbmQgaWYg
SSBoYXZlIHRoaXMgd3JvbmcsIHBsZWFzZSBzYXkNCj4gc28pLg0KPiANCj4gQXJlIHlvdSBzYXlp
bmcgKmJvdGgqIHRoZSBvbGQgKHBjaS1zdHlsZSkgZHJpdmVyIGFuZCBteSBuZXcgZHJpdmVyIChB
Q1BJKSBhcmUNCj4gbG9hZGVkPyAgT3Igc29tZXRoaW5nIGVsc2U/DQoNCllvdXIgQUNQSSBkcml2
ZXIgaXMgbG9hZGVkLiBUaGUgdXNlciBhdHRlbXB0cyB0byByZWFkIGEgdmFsdWUgZnJvbSBhDQp0
aGVybWFsIGh3bW9uIGNoaXAuIFlvdSBleGVjdXRlIFNCV0IgaW4gb3JkZXIgdG8gd3JpdGUgdGhl
IHJlZ2lzdGVyDQphZGRyZXNzIHRvIHRoZSBjaGlwLiBZb3UgdGhlbiB0YWtlIGFuIEFDUEkgaW50
ZXJydXB0LiBUaGUgQUNQSSBjb3JlDQpleGVjdXRlcyBhIG1ldGhvZCB0aGF0IGV4ZWN1dGVzIFNC
V0IgYW5kIHdyaXRlcyBhIGRpZmZlcmVudCByZWdpc3Rlcg0KYWRkcmVzcyB0byB0aGUgY2hpcC4g
Q29udHJvbCBwYXNzZXMgYmFjayB0byB5b3UuIFlvdSBjYWxsIFNCUkIgYW5kIHJlYWQNCmJhY2sg
YSB2YWx1ZSBmcm9tIHRoZSB3cm9uZyByZWdpc3Rlci4NCg0KLS0gDQpNYXR0aGV3IEdhcnJldHQg
PG1hdHRoZXcuZ2FycmV0dEBuZWJ1bGEuY29tPg0K
