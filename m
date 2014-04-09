From: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 9 Apr 2014 17:37:14 +0000
Message-ID: <1397065034.5276.19.camel@x230>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>
	 <1397061392.5276.11.camel@x230> <53457D0D.7020805@redhat.com>
	 <1397063381.5276.17.camel@x230> <5345849F.6070909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5345849F.6070909-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <934CF0C4E4A321408530608A3F98B23D-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

T24gV2VkLCAyMDE0LTA0LTA5IGF0IDEzOjM0IC0wNDAwLCBQcmFyaXQgQmhhcmdhdmEgd3JvdGU6
DQo+IE9uIDA0LzA5LzIwMTQgMDE6MDkgUE0sIE1hdHRoZXcgR2FycmV0dCB3cm90ZToNCj4gPiBJ
bWFnaW5lIGFuIGkyYyBjaGlwIHdpdGggaW5kZXhlZCByZWdpc3RlciBhY2Nlc3MuIFdoYXQgc3Rv
cHM6DQo+ID4gDQo+ID4gQ1BVMCAoaTJjKToJCUNQVTEgKEFDUEkpOg0KPiA+IFNCV0IgcmVnaXN0
ZXIgYWRkcmVzcw0KPiA+IAkJCVNCV0IgcmVnaXN0ZXIgYWRkcmVzcw0KPiA+IFNCUkIgcmVnaXN0
ZXIgdmFsdWUNCj4gPiAJCQlTQlJCIHJlZ2lzdGVyIHZhbHVlDQo+ID4gDQo+IA0KPiBZb3VyIGV4
YW1wbGUgaXMgbm8gZGlmZmVyZW50IGZyb20gd2hhdCB3ZSd2ZSB0b2xkIHBlb3BsZSB0byBkbyBy
aWdodCBub3cgd2hlbg0KPiB0aGV5IHNlZSB0aGUgQUNQSSByZXNvdXJjZSBjb25mbGljdCBtZXNz
YWdlIGFuZCB1c2UgYSBrZXJuZWwgcGFyYW1ldGVyIHRvDQo+IG92ZXJyaWRlIHRoZSBlcnJvciBj
b25kaXRpb24uICBJJ20gbm90IGRpc3B1dGluZyB0aGF0IHRoaXMgY291bGQgYmUgYSBwcm9ibGVt
IC0tDQo+IHNlZSBteSBwcmV2aW91cyBjb21tZW50IGFib3V0IGhvcGluZyB0aGF0IHNvbWVvbmUg
QCBJbnRlbCB3aWxsIGxldCB1cyBrbm93IGlmDQo+IHdlJ3JlIGRvaW5nIHNvbWV0aGluZyBob3Jy
aWJsZS4NCg0KUmlnaHQuIEl0J3MgZGFuZ2Vyb3VzLCB3aGljaCBpcyB3aHkgd2UgZm9yYmlkIGl0
IGJ5IGRlZmF1bHQuIEhvdyBkbyB3ZQ0KYmVuZWZpdCBmcm9tIGhhdmluZyBhIGRyaXZlciB0aGF0
J3Mgbm8gc2FmZXI/DQoNCi0tIA0KTWF0dGhldyBHYXJyZXR0IDxtYXR0aGV3LmdhcnJldHRAbmVi
dWxhLmNvbT4NCg==
