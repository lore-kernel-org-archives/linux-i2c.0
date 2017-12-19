From: "Zhang, Sean C. (NSB - CN/Hangzhou)" <sean.c.zhang@nokia-sbell.com>
Subject: RE: [Bug fix] octeon-i2c driver improvement [2/2]
Date: Tue, 19 Dec 2017 05:25:49 +0000
Message-ID: <VI1PR0702MB36156DA2F16D4794E1ED99B78E0F0@VI1PR0702MB3615.eurprd07.prod.outlook.com>
References: <VI1PR0702MB3615214734CE3D595C4A58618E320@VI1PR0702MB3615.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr20101.outbound.protection.outlook.com ([40.107.2.101]:20512
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759913AbdLSFZx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 19 Dec 2017 00:25:53 -0500
In-Reply-To: <VI1PR0702MB3615214734CE3D595C4A58618E320@VI1PR0702MB3615.eurprd07.prod.outlook.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jan.glauber@caviumnetworks.com>, "david.daney@cavium.com" <david.daney@cavium.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

SGkgSmFuIGFuZCBEYXZpZCwNCg0KQW55IG90aGVyIGNvbW1lbnQgZm9yIHRoZXNlIHRocmVlIHBh
dGNoZXM/IEkgc2VudCB0aGVtIHNlcGFyYXRlbHkuDQoxLiBbQnVnIGZpeF0gb2N0ZW9uLWkyYyBk
cml2ZXIgdXBkYXRlcw0KMi4gW0J1ZyBmaXhdIG9jdGVvbi1pMmMgZHJpdmVyIGltcHJvdmVtZW50
IFsxLzJdDQozLiBbQnVnIGZpeF0gb2N0ZW9uLWkyYyBkcml2ZXIgaW1wcm92ZW1lbnQgWzIvMl0N
Cg0KDQpCUiwNClNlYW4gWmhhbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IFpoYW5nLCBTZWFuIEMuIChOU0IgLSBDTi9IYW5nemhvdSkgDQpTZW50OiBXZWRuZXNkYXksIERl
Y2VtYmVyIDA2LCAyMDE3IDU6NTEgUE0NClRvOiAnRGF2aWQgRGFuZXknIDxkZGFuZXlAY2F2aXVt
bmV0d29ya3MuY29tPjsgJ0phbiBHbGF1YmVyJyA8amFuLmdsYXViZXJAY2F2aXVtbmV0d29ya3Mu
Y29tPjsgJ2RhdmlkLmRhbmV5QGNhdml1bS5jb20nIDxkYXZpZC5kYW5leUBjYXZpdW0uY29tPg0K
Q2M6ICd3c2FAdGhlLWRyZWFtcy5kZScgPHdzYUB0aGUtZHJlYW1zLmRlPjsgJ2xpbnV4LWkyY0B2
Z2VyLmtlcm5lbC5vcmcnIDxsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnPjsgJ2xpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KU3ViamVj
dDogW0J1ZyBmaXhdIG9jdGVvbi1pMmMgZHJpdmVyIGltcHJvdmVtZW50IFsyLzJdDQoNCkhpIEph
biBhbmQgRGF2aWQsDQoNCkZvciBvY3Rlb24taTJjIGRyaXZlciwgdGhlcmUgaGFzIGR1cGxpY2F0
ZWQgaW50ZXJydXB0IGRpc2FibGUgaW4gb2N0ZW9uX2kyY19pc3IoKSwNCm9jdGVvbl9pMmNfaGxj
X3dhaXQoKSBhbmQgb2N0ZW9uX2kyY193YWl0KCksIHNpbmNlIG9jdGVvbl9pMmNfaGxjX3dhaXQo
KSBhbmQNCm9jdGVvbl9pMmNfd2FpdCgpIGhhcyBwYWlyIG9mIGludGVycnVwdCBlbmFibGUgYW5k
IGRpc2FibGUsIHNvIHRoZSBpbnRlcnJ1cHQgZGlzYWJsZSBpbiBvY3Rlb25faTJjX2lzcigpIGlz
IG5vdCBuZWNlc3NhcnkuIGF0dGFjaGVkIHBhdGNoIHJlbW92ZWQgdGhpcyB1bm5lY2Vzc2FyeSBp
bnRlcnJ1cHQgZGlzYWJsZSBzdGVwLg0KDQpQbGVhc2UgaGF2ZSB0aW1lIHRvIHJldmlldyBpdC4g
VGhhbmtzLg0KDQpCUg0KU2VhbiBaaGFuZw0K
