From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH 10/17] media: platform: sti: c8sectpfe: c8sectpfe-dvb:
 convert to use i2c_new_client_device()
Date: Thu, 7 Nov 2019 09:59:17 +0000
Message-ID: <e4fd1be9-9406-7701-9864-56981d486f6f@st.com>
References: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
 <20191106212120.27983-11-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106212120.27983-11-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Content-ID: <CB0A9BA7A9BF554983B74248C1130533@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

SGkNCg0KT24gMTEvNi8xOSAxMDoyMSBQTSwgV29sZnJhbSBTYW5nIHdyb3RlOg0KPiBVc2UgdGhl
IG5ld2VyIEFQSSByZXR1cm5pbmcgYW4gRVJSUFRSIGFuZCB1c2UgdGhlIG5ldyBoZWxwZXIgdG8g
YmFpbA0KPiBvdXQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVz
YXNAc2FuZy1lbmdpbmVlcmluZy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9zdGkvYzhzZWN0cGZlL2M4c2VjdHBmZS1kdmIuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vc3RpL2M4c2VjdHBmZS9jOHNlY3RwZmUtZHZiLmMgYi9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL3N0aS9jOHNlY3RwZmUvYzhzZWN0cGZlLWR2Yi5jDQo+IGluZGV4
IGE3OTI1MGE3ZjgxMi4uMTAzODcyMjY2NTY1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL3N0aS9jOHNlY3RwZmUvYzhzZWN0cGZlLWR2Yi5jDQo+ICsrKyBiL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vc3RpL2M4c2VjdHBmZS9jOHNlY3RwZmUtZHZiLmMNCj4gQEAgLTE3MCw4
ICsxNzAsOCBAQCBpbnQgYzhzZWN0cGZlX2Zyb250ZW5kX2F0dGFjaChzdHJ1Y3QgZHZiX2Zyb250
ZW5kICoqZmUsDQo+ICANCj4gIAkJLyogYXR0YWNoIHR1bmVyICovDQo+ICAJCXJlcXVlc3RfbW9k
dWxlKCJ0ZGExODIxMiIpOw0KPiAtCQljbGllbnQgPSBpMmNfbmV3X2RldmljZSh0c2luLT5pMmNf
YWRhcHRlciwgJnRkYTE4MjEyX2luZm8pOw0KPiAtCQlpZiAoIWNsaWVudCB8fCAhY2xpZW50LT5k
ZXYuZHJpdmVyKSB7DQo+ICsJCWNsaWVudCA9IGkyY19uZXdfY2xpZW50X2RldmljZSh0c2luLT5p
MmNfYWRhcHRlciwgJnRkYTE4MjEyX2luZm8pOw0KPiArCQlpZiAoIWkyY19jbGllbnRfaGFzX2Ry
aXZlcihjbGllbnQpKSB7DQo+ICAJCQlkdmJfZnJvbnRlbmRfZGV0YWNoKCpmZSk7DQo+ICAJCQly
ZXR1cm4gLUVOT0RFVjsNCj4gIAkJfQ0KDQpSZXZpZXdlZC1ieTogUGF0cmljZSBDaG90YXJkIDxw
YXRyaWNlLmNob3RhcmRAc3QuY29tPg0KDQoNClRoYW5rcw0K
