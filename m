From: Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Date: Tue, 4 Sep 2018 11:03:35 +0000
Message-ID: <E73421F5-DC9B-4000-B282-FF71D7E45866@cadence.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
 <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon>
 <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com>
 <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
 <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com>
Content-Language: en-US
Content-ID: <333A476A334B654787EAC7B600AFC919@namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vitor <Vitor.Soares@synopsys.com>, Boris Brezillon <boris.brezillon@bootlin.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@>
List-Id: linux-i2c@vger.kernel.org

SGkgVml0b3IsDQoNCu+7v09uIDkvMy8xOCwgMTE6MzMgQU0sICJ2aXRvciIgPFZpdG9yLlNvYXJl
c0BzeW5vcHN5cy5jb20+IHdyb3RlOg0KDQogICAgRVhURVJOQUwgTUFJTA0KICAgIA0KICAgIA0K
ICAgIEhpIFByemVtZWssDQogICAgDQogICAgDQogICAgT24gMzAtMDgtMjAxOCAyMDowMCwgUHJ6
ZW15c2xhdyBHYWogd3JvdGU6DQogICAgPiAgICAgIFNvLCBwZXIgbXkgdW5kZXJzdGFuZGluZyBz
aW5jZSB0aGUgTWFpbiBtYXN0ZXIgc3VwcG9ydCB0aGUgaGFuZC1vZmYgb2YNCiAgICA+ICAgICAg
dGhlIGJ1cyB5b3UgYWNjZXB0IGFsbCBpbmNvbWluZyBNUiwgcmlnaHQ/IE9yIGRvIHlvdSBjaGVj
ayBhbGwgZGV2aWNlcyBCQ1I/DQogICAgPg0KICAgID4gSSdtIG5vdCBzdXJlIHdoYXQgZG8geW91
IG1lYW4gaGVyZS4gTWFzdGVyc2hpcCByZXF1ZXN0KE1SKSBpcyBmcm9tIHNlY29uZGFyeSBtYXN0
ZXINCiAgICA+IHRvIGN1cnJlbnQgbWFzdGVyLiBDdXJyZW50IG1hc3RlciBjYW4gTkFDSyB0aGlz
IHJlcXVlc3QgaWYgZm9yIGV4YW1wbGUgaXQgY29tZXMgZnJvbQ0KICAgID4gd3JvbmcgZGV2aWNl
LiBJZiBpdCdzIG9rLCBjdXJyZW50IG1hc3RlciBzZW5kcyBHRVRBQ0NNU1QgY29tbWFuZCBhbmQg
c2Vjb25kYXJ5IG1hc3Rlcg0KICAgID4gbWF5IEFDSyBvciBOQUNLIHRoaXMgY29tbWFuZC4gSXQg
aXQncyBhY2tlZCwgc2Vjb25kYXJ5IG1hc3RlciBiZWNvbWVzIGN1cnJlbnQgbWFzdGVyLg0KICAg
ID4gICAgICANCiAgICA+ICAgICAgQmVzdCByZWdhcmRzLA0KICAgID4gICAgICBWaXRvciBTb2Fy
ZXMNCiAgICA+DQogICAgPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgc29tZXRoaW5nIGlzIHVuY2xl
YXIuDQogICAgPg0KICAgID4gUmVnYXJkcywNCiAgICA+IFByemVtZWsNCiAgICA+ICAgICAgDQog
ICAgDQogICAgU29ycnksIGl0IHMgbm90IGNsZWFyIHlldC4NCiAgICANCiAgICBGb3IgaW5zdGFu
Y2VzIHRoZXJlIGlzIGEgYnVzIHdpdGggc2V2ZXJhbCBzZWNvbmRhcnkgbWFzdGVyLiBJZiBlYWNo
IG9mIA0KICAgIHRoZW0gcmVxdWVzdCB0aGUgYnVzIG1hc3RlcnNoaXAgKG9uZSBhdCBhIHRpbWUp
LCB3aWxsIHlvdSBhY2NlcHQgYWxsIGJ5IA0KICAgIGRlZmF1bHQ/IEJlY2F1c2UgeW91IGNhbiBv
bmx5IGFjY2VwdCBvbmx5IHNvbWUgb2YgdGhlbS4NCg0KRmlyc3Qgb2YgYWxsLCBvbmx5IGRldmlj
ZXMgd2hpY2ggaGF2ZSBNYXN0ZXJzaGlwIHJlcXVlc3QgZXZlbnQgZW5hYmxlZCAoRU5NUiBzbGF2
ZSBldmVudCkNCmNhbiByZXF1ZXN0IG1hc3RlcnNoaXAuIFNlY29uZCB0aGluZyBpcyB0aGF0IHRo
aXMgZGV2aWNlIG5lZWRzIHRvIGhhdmUgSUJJIGVuYWJsZWQgaW4gDQpjdXJyZW50IG1hc3Rlci4g
SSBhY2NlcHQgYWxsIHN1Y2ggZGV2aWNlcy4gVGhlcmUgaXMgbm8gYWRkaXRpb25hbCBsb2dpYyBm
b3Igbm93LCB3ZSBjYW4gYWRkIGl0DQppbiB0aGUgZnV0dXJlLg0KDQpJIHdhcyB2ZXJ5IGJ1c3kg
cmVjZW50bHkuIEknbSBhbG1vc3QgcmVhZHkgdG8gcHVibGlzaCBteSBjaGFuZ2VzIHJlbGF0ZWQg
dG8gbWFzdGVyc2hpcCByZXF1ZXN0Lg0KSSdtIHNvcnJ5IGZvciB0aGUgZGVsYXkuDQogICAgDQog
ICAgUmVnYXJkcywNCiAgICBWaXRvciBTb2FyZXMNCiAgICANClJlZ2FyZHMsDQpQcnplbWVrDQoN
Cg==
