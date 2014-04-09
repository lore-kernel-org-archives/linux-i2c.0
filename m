From: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 9 Apr 2014 17:59:03 +0000
Message-ID: <1397066342.5276.21.camel@x230>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>
	 <1397061392.5276.11.camel@x230> <53457D0D.7020805@redhat.com>
	 <1397063381.5276.17.camel@x230> <5345849F.6070909@redhat.com>
	 <1397065034.5276.19.camel@x230> <53458992.4060003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53458992.4060003-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <189436DDB844CF45929445281CEE7DF2-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

T24gV2VkLCAyMDE0LTA0LTA5IGF0IDEzOjU1IC0wNDAwLCBQcmFyaXQgQmhhcmdhdmEgd3JvdGU6
DQo+IA0KPiBPbiAwNC8wOS8yMDE0IDAxOjM3IFBNLCBNYXR0aGV3IEdhcnJldHQgd3JvdGU6DQo+
ID4gUmlnaHQuIEl0J3MgZGFuZ2Vyb3VzLCB3aGljaCBpcyB3aHkgd2UgZm9yYmlkIGl0IGJ5IGRl
ZmF1bHQuIEhvdyBkbyB3ZQ0KPiA+IGJlbmVmaXQgZnJvbSBoYXZpbmcgYSBkcml2ZXIgdGhhdCdz
IG5vIHNhZmVyPw0KPiANCj4gV2UgaGF2ZSB5ZXQgdG8gc2VlIHdoZXJlIHRoZSBleGlzdGluZyBj
YXNlIGV4aGliaXRzIHRoZSBiZWhhdmlvdXIgb2YgYSByYWNlLiAgSW4NCj4gZmFjdCwgQUZBSUNU
LCBhbGwgd2UndmUgc2VlbiBpcyBzdGFiaWxpdHkuICBTbyBpdCdzIG5vIHNhZmVyPyAgWWVwLiAg
SXQncyBhcw0KPiBlcXVhbGx5IG5vdCByYWN5IGFzIHRoZSBleGlzdGluZyB3b3JrYXJvdW5kLg0K
DQpTby4uLiB3aHkgYWRkIHRoZSBkcml2ZXIgYXQgYWxsPyBSZWZ1c2luZyB0byBwZXJtaXQgdGhl
IGtlcm5lbCB0byB0b3VjaA0KdGhlc2UgcmVzb3VyY2VzIGlzIGEgZGVsaWJlcmF0ZSBkZXNpZ24g
Y2hvaWNlLCBiZWNhdXNlIG9mIHRoZSBwb3RlbnRpYWwNCmZvciB0aGVzZSByYWNlcy4gSXQnbGwg
d29yayBhYnNvbHV0ZWx5IGZpbmUgcmlnaHQgdXAgdW50aWwgdGhlIHBvaW50DQp3aGVyZSB5b3Ug
ZW5kIHVwIHJlYWRpbmcgdGhlIHdyb25nIHRlbXBlcmF0dXJlIHZhbHVlIGZyb20gYW4gaTJjIGh3
bW9uDQpjaGlwIGFuZCBwZXJmb3JtIGEgY3JpdGljYWwgdGhlcm1hbCBzaHV0ZG93bi4NCg0KLS0g
DQpNYXR0aGV3IEdhcnJldHQgPG1hdHRoZXcuZ2FycmV0dEBuZWJ1bGEuY29tPg0K
