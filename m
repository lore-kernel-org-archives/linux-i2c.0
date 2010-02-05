From: zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] fix i2c_msg.len not aligning with i2c_master_send
Date: Fri, 5 Feb 2010 13:51:19 +0800
Message-ID: <309424b61002042151i2a762d41md3521a820fd45622@mail.gmail.com>
References: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
	 <20100204103530.65429c04@hyperion.delvare>
	 <309424b61002040438i2fae055dt2d3ef528eae99b48@mail.gmail.com>
	 <f17812d71002040447y4b6f889o1137ae6149559994@mail.gmail.com>
	 <20100204141451.3e0f865e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c14fc691c1d047ed40adb
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100204141451.3e0f865e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--0015174c14fc691c1d047ed40adb
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Feb 4, 2010 at 9:14 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Thu, 4 Feb 2010 04:47:41 -0800, Eric Miao wrote:
>> > How about return error in i2c_master_send & i2c_master_recv when count
>> > is bigger than 64K, as suggested by Ben.
>>
>> I think that's more preferable. Making the count parameter as u16,
>> though is going to generate a warning, yet that's usually ignored
>> by careless programmer, screaming out when this happens might
>> be more useful sometimes.
>
> Developers ignoring warnings get the pain the deserve.
>
> A check on "count" would come at the price of a small performance hit
> for every caller, even though in 99% of the cases the check isn't
> needed.
>
> That being said I don't care too much and will take whatever patch is
> sent to me.
>
> It would be a good idea to add a note about this limit in
> Documentation/i2c/writing-clients and/or include/linux/i2c.h.
>
>> > The device I used could receive 32K one time instead, the firmware
>> > download only takes place on-demand in fact.
>> > However, it took some time to debug, since no error info come out.
>> > Add error msg may notify users, though transfering more than 64K data
>> > one time is rarely happen.
>
> --
> Jean Delvare
>

Hi, Jean

Thanks for your instruction.
Here is patch to modify some comments of i2c_master_send &
i2c_master_recv, is this OK.

Thanks
Zhangfei

>From 30fbf1ebf1facba3d280c887e2ecfd0499e7b04b Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zgao6-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Date: Sat, 6 Feb 2010 05:38:59 +0800
Subject: [PATCH] i2c: notes of i2c_master_send & i2c_master_recv

	i2c_master_send & i2c_master_recv not support more than 64bytes
transfer, since msg.len is __u16 type

Signed-off-by: Zhangfei Gao <zgao6-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/i2c/writing-clients |    3 ++-
 drivers/i2c/i2c-core.c            |    4 ++--
 include/linux/i2c.h               |    1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/writing-clients
b/Documentation/i2c/writing-clients
index 7860aaf..929a3c3 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -318,7 +318,8 @@ Plain I2C communication
 These routines read and write some bytes from/to a client. The client
 contains the i2c address, so you do not have to include it. The second
 parameter contains the bytes to read/write, the third the number of bytes
-to read/write (must be less than the length of the buffer.) Returned is
+to read/write (must be less than the length of the buffer, also should be
+less than 64K since msg.len is __u16 type.) Returned is
 the actual number of bytes read/written.

 	int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 8d80fce..9607dcc 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1112,7 +1112,7 @@ EXPORT_SYMBOL(i2c_transfer);
  * i2c_master_send - issue a single I2C message in master transmit mode
  * @client: Handle to slave device
  * @buf: Data that will be written to the slave
- * @count: How many bytes to write
+ * @count: How many bytes to write, should be less than 64K since
msg.len is u16
  *
  * Returns negative errno, or else the number of bytes written.
  */
@@ -1139,7 +1139,7 @@ EXPORT_SYMBOL(i2c_master_send);
  * i2c_master_recv - issue a single I2C message in master receive mode
  * @client: Handle to slave device
  * @buf: Where to store data read from slave
- * @count: How many bytes to read
+ * @count: How many bytes to read, should be less than 64K since msg.len is u16
  *
  * Returns negative errno, or else the number of bytes read.
  */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 57d41b0..b2dea18 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -53,6 +53,7 @@ struct i2c_board_info;
  * on a bus (or read from them). Apart from two basic transfer functions to
  * transmit one message at a time, a more complex version can be used to
  * transmit an arbitrary number of messages without interruption.
+ * Parameter count should be less than 64K since msg.len is __u16
  */
 extern int i2c_master_send(struct i2c_client *client, const char *buf,
 			   int count);
-- 
1.6.0.4

--0015174c14fc691c1d047ed40adb
Content-Type: application/octet-stream;
	name="0001-i2c-notes-of-i2c_master_send-i2c_master_recv.patch"
Content-Disposition: attachment;
	filename="0001-i2c-notes-of-i2c_master_send-i2c_master_recv.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5ajy6j90

RnJvbSAzMGZiZjFlYmYxZmFjYmEzZDI4MGM4ODdlMmVjZmQwNDk5ZTdiMDRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBTYXQsIDYgRmViIDIwMTAgMDU6Mzg6NTkgKzA4MDAKU3ViamVjdDogW1BBVENIXSBpMmM6IG5v
dGVzIG9mIGkyY19tYXN0ZXJfc2VuZCAmIGkyY19tYXN0ZXJfcmVjdgoKCWkyY19tYXN0ZXJfc2Vu
ZCAmIGkyY19tYXN0ZXJfcmVjdiBub3Qgc3VwcG9ydCBtb3JlIHRoYW4gNjRieXRlcyB0cmFuc2Zl
ciwgc2luY2UgbXNnLmxlbiBpcyBfX3UxNiB0eXBlCgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBH
YW8gPHpnYW82QG1hcnZlbGwuY29tPgotLS0KIERvY3VtZW50YXRpb24vaTJjL3dyaXRpbmctY2xp
ZW50cyB8ICAgIDMgKystCiBkcml2ZXJzL2kyYy9pMmMtY29yZS5jICAgICAgICAgICAgfCAgICA0
ICsrLS0KIGluY2x1ZGUvbGludXgvaTJjLmggICAgICAgICAgICAgICB8ICAgIDEgKwogMyBmaWxl
cyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9pMmMvd3JpdGluZy1jbGllbnRzIGIvRG9jdW1lbnRhdGlvbi9pMmMvd3Jp
dGluZy1jbGllbnRzCmluZGV4IDc4NjBhYWYuLjkyOWEzYzMgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50
YXRpb24vaTJjL3dyaXRpbmctY2xpZW50cworKysgYi9Eb2N1bWVudGF0aW9uL2kyYy93cml0aW5n
LWNsaWVudHMKQEAgLTMxOCw3ICszMTgsOCBAQCBQbGFpbiBJMkMgY29tbXVuaWNhdGlvbgogVGhl
c2Ugcm91dGluZXMgcmVhZCBhbmQgd3JpdGUgc29tZSBieXRlcyBmcm9tL3RvIGEgY2xpZW50LiBU
aGUgY2xpZW50CiBjb250YWlucyB0aGUgaTJjIGFkZHJlc3MsIHNvIHlvdSBkbyBub3QgaGF2ZSB0
byBpbmNsdWRlIGl0LiBUaGUgc2Vjb25kCiBwYXJhbWV0ZXIgY29udGFpbnMgdGhlIGJ5dGVzIHRv
IHJlYWQvd3JpdGUsIHRoZSB0aGlyZCB0aGUgbnVtYmVyIG9mIGJ5dGVzCi10byByZWFkL3dyaXRl
IChtdXN0IGJlIGxlc3MgdGhhbiB0aGUgbGVuZ3RoIG9mIHRoZSBidWZmZXIuKSBSZXR1cm5lZCBp
cwordG8gcmVhZC93cml0ZSAobXVzdCBiZSBsZXNzIHRoYW4gdGhlIGxlbmd0aCBvZiB0aGUgYnVm
ZmVyLCBhbHNvIHNob3VsZCBiZQorbGVzcyB0aGFuIDY0SyBzaW5jZSBtc2cubGVuIGlzIF9fdTE2
IHR5cGUuKSBSZXR1cm5lZCBpcwogdGhlIGFjdHVhbCBudW1iZXIgb2YgYnl0ZXMgcmVhZC93cml0
dGVuLgogCiAJaW50IGkyY190cmFuc2ZlcihzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXAsIHN0cnVj
dCBpMmNfbXNnICptc2csCmRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9pMmMtY29yZS5jIGIvZHJp
dmVycy9pMmMvaTJjLWNvcmUuYwppbmRleCA4ZDgwZmNlLi45NjA3ZGNjIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2kyYy9pMmMtY29yZS5jCisrKyBiL2RyaXZlcnMvaTJjL2kyYy1jb3JlLmMKQEAgLTEx
MTIsNyArMTExMiw3IEBAIEVYUE9SVF9TWU1CT0woaTJjX3RyYW5zZmVyKTsKICAqIGkyY19tYXN0
ZXJfc2VuZCAtIGlzc3VlIGEgc2luZ2xlIEkyQyBtZXNzYWdlIGluIG1hc3RlciB0cmFuc21pdCBt
b2RlCiAgKiBAY2xpZW50OiBIYW5kbGUgdG8gc2xhdmUgZGV2aWNlCiAgKiBAYnVmOiBEYXRhIHRo
YXQgd2lsbCBiZSB3cml0dGVuIHRvIHRoZSBzbGF2ZQotICogQGNvdW50OiBIb3cgbWFueSBieXRl
cyB0byB3cml0ZQorICogQGNvdW50OiBIb3cgbWFueSBieXRlcyB0byB3cml0ZSwgc2hvdWxkIGJl
IGxlc3MgdGhhbiA2NEsgc2luY2UgbXNnLmxlbiBpcyB1MTYKICAqCiAgKiBSZXR1cm5zIG5lZ2F0
aXZlIGVycm5vLCBvciBlbHNlIHRoZSBudW1iZXIgb2YgYnl0ZXMgd3JpdHRlbi4KICAqLwpAQCAt
MTEzOSw3ICsxMTM5LDcgQEAgRVhQT1JUX1NZTUJPTChpMmNfbWFzdGVyX3NlbmQpOwogICogaTJj
X21hc3Rlcl9yZWN2IC0gaXNzdWUgYSBzaW5nbGUgSTJDIG1lc3NhZ2UgaW4gbWFzdGVyIHJlY2Vp
dmUgbW9kZQogICogQGNsaWVudDogSGFuZGxlIHRvIHNsYXZlIGRldmljZQogICogQGJ1ZjogV2hl
cmUgdG8gc3RvcmUgZGF0YSByZWFkIGZyb20gc2xhdmUKLSAqIEBjb3VudDogSG93IG1hbnkgYnl0
ZXMgdG8gcmVhZAorICogQGNvdW50OiBIb3cgbWFueSBieXRlcyB0byByZWFkLCBzaG91bGQgYmUg
bGVzcyB0aGFuIDY0SyBzaW5jZSBtc2cubGVuIGlzIHUxNgogICoKICAqIFJldHVybnMgbmVnYXRp
dmUgZXJybm8sIG9yIGVsc2UgdGhlIG51bWJlciBvZiBieXRlcyByZWFkLgogICovCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2kyYy5oIGIvaW5jbHVkZS9saW51eC9pMmMuaAppbmRleCA1N2Q0
MWIwLi5iMmRlYTE4IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2kyYy5oCisrKyBiL2luY2x1
ZGUvbGludXgvaTJjLmgKQEAgLTUzLDYgKzUzLDcgQEAgc3RydWN0IGkyY19ib2FyZF9pbmZvOwog
ICogb24gYSBidXMgKG9yIHJlYWQgZnJvbSB0aGVtKS4gQXBhcnQgZnJvbSB0d28gYmFzaWMgdHJh
bnNmZXIgZnVuY3Rpb25zIHRvCiAgKiB0cmFuc21pdCBvbmUgbWVzc2FnZSBhdCBhIHRpbWUsIGEg
bW9yZSBjb21wbGV4IHZlcnNpb24gY2FuIGJlIHVzZWQgdG8KICAqIHRyYW5zbWl0IGFuIGFyYml0
cmFyeSBudW1iZXIgb2YgbWVzc2FnZXMgd2l0aG91dCBpbnRlcnJ1cHRpb24uCisgKiBQYXJhbWV0
ZXIgY291bnQgc2hvdWxkIGJlIGxlc3MgdGhhbiA2NEsgc2luY2UgbXNnLmxlbiBpcyBfX3UxNgog
ICovCiBleHRlcm4gaW50IGkyY19tYXN0ZXJfc2VuZChzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50
LCBjb25zdCBjaGFyICpidWYsCiAJCQkgICBpbnQgY291bnQpOwotLSAKMS42LjAuNAoK
--0015174c14fc691c1d047ed40adb--
