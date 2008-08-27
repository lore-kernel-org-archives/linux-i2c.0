From: "Davide Rizzo" <elpa.rizzo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Modify proposal to manage LM75A chips
Date: Wed, 27 Aug 2008 09:46:56 +0200
Message-ID: <8447d6730808270046k7409f1f1v56baa510bc2bf7fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_18404_15332155.1219823216056"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

------=_Part_18404_15332155.1219823216056
Content-Type: multipart/alternative;
	boundary="----=_Part_18405_2034643.1219823216056"

------=_Part_18405_2034643.1219823216056
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I suggest this modify to make LM75 driver support also LM75A chips, that
otherwise fail a bug-based identification test.

------=_Part_18405_2034643.1219823216056
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">I suggest this modify to make LM75 driver support also LM75A chips, that otherwise fail a bug-based identification test.<br></div>

------=_Part_18405_2034643.1219823216056--

------=_Part_18404_15332155.1219823216056
Content-Type: application/octet-stream; name=lm75a.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fkdn6j540
Content-Disposition: attachment; filename=lm75a.patch

VGhpcyBjaGVjayBpcyBub3Qgd29ya2luZyBvbiBMTTc1QS4KSWYgeW91IHJlbW92ZSBpdCwgdGhl
IGRyaXZlciB3aWxsIHdvcmsgYWxzbyB3aXRoIExNNzVBIGNoaXBzLgoKU2lnbmVkLW9mZi1ieTog
RGF2aWRlIFJpenpvIDxkYXZpZGVAZWxwYS5pdD4KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KZGlm
ZiAtdXJOcCBsaW51eC0yLjYuMjYvZHJpdmVycy9od21vbi9sbTc1LmMgbGludXgtMi42LjI2LmVs
cGEvZHJpdmVycy9od21vbi9sbTc1LmMKLS0tIGxpbnV4LTIuNi4yNi9kcml2ZXJzL2h3bW9uL2xt
NzUuYwkyMDA4LTA3LTEzIDIzOjUxOjI5LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjI2
LmVscGEvZHJpdmVycy9od21vbi9sbTc1LmMJMjAwOC0wOC0yNSAxNjo1ODowNC4wMDAwMDAwMDAg
KzAyMDAKQEAgLTE3MCwxNyArMTcwLDE5IEBAIHN0YXRpYyBpbnQgbG03NV9kZXRlY3Qoc3RydWN0
IGkyY19hZGFwdGUKIAkJY3VyID0gaTJjX3NtYnVzX3JlYWRfd29yZF9kYXRhKG5ld19jbGllbnQs
IDApOwogCQljb25mID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKG5ld19jbGllbnQsIDEpOwog
CQloeXN0ID0gaTJjX3NtYnVzX3JlYWRfd29yZF9kYXRhKG5ld19jbGllbnQsIDIpOworLyoJVGhp
cyB3YXMgZWxpbWluYXRlZCBiZWNhdXNlIExNNzVBIGlzIG5vdCByZWNvZ25pemVkCiAJCWlmIChp
MmNfc21idXNfcmVhZF93b3JkX2RhdGEobmV3X2NsaWVudCwgNCkgIT0gaHlzdAogCQkgfHwgaTJj
X3NtYnVzX3JlYWRfd29yZF9kYXRhKG5ld19jbGllbnQsIDUpICE9IGh5c3QKIAkJIHx8IGkyY19z
bWJ1c19yZWFkX3dvcmRfZGF0YShuZXdfY2xpZW50LCA2KSAhPSBoeXN0CiAJCSB8fCBpMmNfc21i
dXNfcmVhZF93b3JkX2RhdGEobmV3X2NsaWVudCwgNykgIT0gaHlzdCkKLQkJIAlnb3RvIGV4aXRf
ZnJlZTsKKwkJCWdvdG8gZXhpdF9mcmVlOyovCiAJCW9zID0gaTJjX3NtYnVzX3JlYWRfd29yZF9k
YXRhKG5ld19jbGllbnQsIDMpOworLyoJVGhpcyB3YXMgZWxpbWluYXRlZCBiZWNhdXNlIExNNzVB
IGlzIG5vdCByZWNvZ25pemVkCiAJCWlmIChpMmNfc21idXNfcmVhZF93b3JkX2RhdGEobmV3X2Ns
aWVudCwgNCkgIT0gb3MKIAkJIHx8IGkyY19zbWJ1c19yZWFkX3dvcmRfZGF0YShuZXdfY2xpZW50
LCA1KSAhPSBvcwogCQkgfHwgaTJjX3NtYnVzX3JlYWRfd29yZF9kYXRhKG5ld19jbGllbnQsIDYp
ICE9IG9zCiAJCSB8fCBpMmNfc21idXNfcmVhZF93b3JkX2RhdGEobmV3X2NsaWVudCwgNykgIT0g
b3MpCi0JCSAJZ290byBleGl0X2ZyZWU7CisJCQlnb3RvIGV4aXRfZnJlZTsqLwogCiAJCS8qIFVu
dXNlZCBiaXRzICovCiAJCWlmIChjb25mICYgMHhlMCkK
------=_Part_18404_15332155.1219823216056
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
------=_Part_18404_15332155.1219823216056--
