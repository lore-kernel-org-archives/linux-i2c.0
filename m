From: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 9 Apr 2014 18:27:28 +0000
Message-ID: <1397068048.5276.23.camel@x230>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>
	 <1397061392.5276.11.camel@x230> <53457D0D.7020805@redhat.com>
	 <1397063381.5276.17.camel@x230> <5345849F.6070909@redhat.com>
	 <1397065034.5276.19.camel@x230> <53458992.4060003@redhat.com>
	 <1397066342.5276.21.camel@x230> <53458B2A.30003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53458B2A.30003-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <ABD3870F627EA242B279A9339B36C99A-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <janet.morgan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

T24gV2VkLCAyMDE0LTA0LTA5IGF0IDE0OjAyIC0wNDAwLCBQcmFyaXQgQmhhcmdhdmEgd3JvdGU6
DQo+IA0KPiBPbiAwNC8wOS8yMDE0IDAxOjU5IFBNLCBNYXR0aGV3IEdhcnJldHQgd3JvdGU6DQo+
ID4gU28uLi4gd2h5IGFkZCB0aGUgZHJpdmVyIGF0IGFsbD8gUmVmdXNpbmcgdG8gcGVybWl0IHRo
ZSBrZXJuZWwgdG8gdG91Y2gNCj4gPiB0aGVzZSByZXNvdXJjZXMgaXMgYSBkZWxpYmVyYXRlIGRl
c2lnbiBjaG9pY2UsIGJlY2F1c2Ugb2YgdGhlIHBvdGVudGlhbA0KPiA+IGZvciB0aGVzZSByYWNl
cy4gSXQnbGwgd29yayBhYnNvbHV0ZWx5IGZpbmUgcmlnaHQgdXAgdW50aWwgdGhlIHBvaW50DQo+
ID4gd2hlcmUgeW91IGVuZCB1cCByZWFkaW5nIHRoZSB3cm9uZyB0ZW1wZXJhdHVyZSB2YWx1ZSBm
cm9tIGFuIGkyYyBod21vbg0KPiA+IGNoaXAgYW5kIHBlcmZvcm0gYSBjcml0aWNhbCB0aGVybWFs
IHNodXRkb3duLg0KPiANCj4gQmVjYXVzZSBpdCBzZWVtcyBsaWtlIHRoZSAicmlnaHQiIHRoaW5n
IHRvIGRvIGlzIHVzZSB0aGUgQUNQSSBpbnRlcmZhY2UgcmF0aGVyDQo+IHRoYW4gdGhlIGk4MDEg
cGNpIGRyaXZlci4gIEF0IGxlYXN0IHRvIG1lIHRoYXQgbWFrZXMgc2Vuc2UuICBPVE9ILCBpZiBK
ZWFuDQo+IHRoaW5rcyB0aGVyZSBpc24ndCBhIG5lZWQgSSBjYW4gZHJvcCBpdC4NCg0KV2Ugc2hv
dWxkIHVzZSBhbnkgQUNQSSBpbnRlcmZhY2UgdGhhdCBhbGxvd3MgdXMgdG8gcGVyZm9ybSBhcHBy
b3ByaWF0ZQ0Kc3luY2hyb25pc2F0aW9uIHdpdGggdGhlIGhhcmR3YXJlLCBidXQgdGhlcmUncyBu
byByZWFsIGFkdmFudGFnZSBpbg0KdXNpbmcgYW4gQUNQSSBpbnRlcmZhY2UgdGhhdCdzIHN0aWxs
IHJhY3kuDQoNCi0tIA0KTWF0dGhldyBHYXJyZXR0IDxtYXR0aGV3LmdhcnJldHRAbmVidWxhLmNv
bT4NCg==
