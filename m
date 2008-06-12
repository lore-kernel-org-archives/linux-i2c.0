From: "Eric Brower" <ebrower-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: multi-master lost-arbitration improvement for
	i2c-algo-pcf (take 2)
Date: Thu, 12 Jun 2008 14:10:03 -0700
Message-ID: <ec7cefb0806121410g154b546dx1cb2562898dba4b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_959_20276858.1213305003589"
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

------=_Part_959_20276858.1213305003589
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a revised patch to provide enhanced multi-master
arbitration support for i2c-algo-pcf.  The initial patch was
commented-on about 10 months ago, so I've included the prior mail
below for reference and interspersed my comments.  I am not a member
of this list, so please copy me directly on replies.  The attached
patch has been tested against a fairly recent Linus 2.6 GIT tree.

Ref: http://lists.lm-sensors.org/pipermail/i2c/2007-August/001690.html

Commit text:
Improve lost-arbitration handling of PCF8584.  This is necessary for
support of a currently out-of-kernel driver for Sun Microsystems E250
environmental management; perhaps others.
Signed-off-by: Eric Brower <ebrower at gmail.com>

Daniel, please ACK if you are comfortable doing so.


> Hi Eric,
>
> When sending a patch, please set the attachment type to something more
> friendly than "application/octet-stream".

Will do.  I've tried to fool gmail with a .txt extension, rather than .patch.

>
> On Thu, 19 Jul 2007 22:26:08 -0700, Eric Brower wrote:
>> Attached is a patch that improves multi-master support for PCF8584.
>> The current implementation of multi-master support (mine) in
>> i2c-algo-pcf does not properly handle a collision detected during wait_for_bb()
>> and thus causes an error that is only recoverable by reloading the
>> relevant device drivers.  I'd appreciate your consideration of this
>> patch.
>>
>> The only affected driver is i2c-envctrl.c-- currently out-of-kernel,
>> in development; you
>> can find it here if you are interested:
>>
>>    http://www.david-web.co.uk/index.php?p=envctrl
>>
>> This change has been tested by a few individuals (on Sun Microsystems
>> E250 servers) over the course of several months, and rectifies
>> occasional errors seen without the patch applied.
>>
>> I'll be happy to provide further clarification if you are interested.
>> Please cc me on responses-- I am not a member of this list.
>
> Note that I can't test your patch, as I don't have supported hardware.
>
>> Commit text:
>>
>> Improve lost-arbitration handling of PCF8584
>> Signed-off-by: Eric Brower <ebrower at gmail.com>
>
> Review:
>
>> diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
>> index ecb2c2d..2cc0302 100644
>> --- a/drivers/i2c/algos/i2c-algo-pcf.c
>> +++ b/drivers/i2c/algos/i2c-algo-pcf.c
>> @@ -78,6 +78,31 @@ static void i2c_stop(struct i2c_algo_pcf
>>  	set_pcf(adap, 1, I2C_PCF_STOP);
>>  }
>>
>> +static inline void handle_lab(struct i2c_algo_pcf_data *adap, const int *status)
>> +{
>> +	DEB2(printk(KERN_INFO
>> +		"i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
>> +		 *status));
>> +	/* Cleanup from LAB-- reset and enable ESO.
>> +	 * This resets the PCF8584; since we've lost the bus, no
>> +	 * further attempts should be made by callers to clean up
>> +	 * (no i2c_stop() etc.)
>> +	 */
>> +	set_pcf(adap, 1, I2C_PCF_PIN);
>> +	set_pcf(adap, 1, I2C_PCF_ESO);
>> +	/* We pause for a time period sufficient for any running
>> +	 * I2C transaction to complete-- the arbitration logic won't
>> +	 * work properly until the next START is seen.
>> +	 * It is assumed the bus driver or client has set a proper value.
>> +	 */
>> +	if (adap->lab_mdelay) {
>> +		mdelay(adap->lab_mdelay);
>> +	}
>
> Out of curiosity: on what basis will the value of lab_mdelay be chosen
> by the driver author? This seems to be pretty arbitrary, as you don't
> know what kind of transactions the other master is doing. The
> underlying question being: is it worth having a per-adapter parameter
> for this, as opposed to a hard-coded value?

The driver (bus adapter) author shall select a value that is longer
than the longest start/stop bus transaction possible by either master.
 This is not entirely arbitrary, and can be determined by snooping the
i2c bus.  Unfortunately, for proper lost-arbitration functionality
with PCF8584 you must determine a sufficient value.  This is described
in the Philips/NXP AN96040 document:

"Attention ! In both cases, the PCF8584 is not able to recognise that
there is still an ongoing
transmission. In order to prevent another arbitration problem the
controlling software should
wait for a time, longer than the longest message which can be sent
over the bus, before trying
to access the bus again."

The parameter should be per-adapter, not hard-coded, for the above reason.

Here's an example of a bus driver (i2c-envctrl) setting a desired value:

static struct i2c_algo_pcf_data pcf_envctrl_data = {
        .setpcf     = pcf_envctrl_setbyte,
        .getpcf     = pcf_envctrl_getbyte,
        .getown     = pcf_envctrl_getown,
        .getclock   = pcf_envctrl_getclock,
        .waitforpin = pcf_envctrl_waitforpin,
        .udelay     = 10,
        .timeout    = 100,
        /*
         * This could be made dynamic based upon get_clock(), but
         * we know clock does not change within this implementation, so:
         * 10,000 uSec per bit (@100kHz) * 9 bits/byte * 3 trans
         */
        .lab_mdelay = 270,
 };


>
> Also, it seems to me that you could sleep here. If you sleep a bit
> longer than expected, it shouldn't be a problem, right?

Not a problem.  The pause is only intended to ensure at least
"lab_mdelay" msecs prior to the next attempt to use the bus.  This
gives the internal state machine of PCF8584 sufficient time to see a
stop or start sequence on the bus.

>
>> +	DEB2(printk(KERN_INFO
>> +		"i2c-algo-pcf.o: reset LAB condition (CSR 0x%02x)\n",
>> +		get_pcf(adap,1)));
>
> Coding style: space after comma.

Done.  Thanks.

>
>> +}
>
> This function is too big to be inlined, especially given that it should
> rarely be called, so speeding it up isn't very interesting.

Understood-- inline removed.

>
>> +
>>  static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
>>
>>  	int timeout = DEF_TIMEOUT;
>> @@ -86,6 +111,10 @@ static int wait_for_bb(struct i2c_algo_p
>>  	status = get_pcf(adap, 1);
>>  #ifndef STUB_I2C
>>  	while (timeout-- && !(status & I2C_PCF_BB)) {
>> +		if (status & I2C_PCF_LAB) {
>> +			handle_lab(adap, &status);
>> +			return -EINTR;
>> +		}
>
> How can this happen? We check for busy bus before we start
> transmitting, and arbitration can't be lost until we at least try to
> transmit.

This is a side-effect that occurs when the lab_mdelay value is not
long enough to ensure a stop or start sequence is seen by the master.
The internal state machine of the PCF8584 can trigger LAB at an
unexpected time.  In fact, you are correct that we should not see it
here; given the current structure of the driver, however, we do see it
here and the driver otherwise makes no attempt to resolve the issue.
This state requires a driver reload to rectify.  Future work on this
driver could perhaps resolve the issue of this (and other unexpected
conditions) via a reset.

However, if we assume the bus driver author has selected a proper
value, we should not expect this to occur.  So, I've removed this
section and it could be added back in the future as "insurance"
against unexpected behavior if necessary.

>
>>  		udelay(100); /* wait for 100 us */
>>  		status = get_pcf(adap, 1);
>>  	}
>
>> @@ -109,23 +139,7 @@ static int wait_for_pin(struct i2c_algo_
>>  		*status = get_pcf(adap, 1);
>>  	}
>>  	if (*status & I2C_PCF_LAB) {
>> -		DEB2(printk(KERN_INFO
>> -			"i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
>> -			 *status));
>> -		/* Cleanup from LAB-- reset and enable ESO.
>> -		 * This resets the PCF8584; since we've lost the bus, no
>> -		 * further attempts should be made by callers to clean up
>> -		 * (no i2c_stop() etc.)
>> -		 */
>> -		set_pcf(adap, 1, I2C_PCF_PIN);
>> -		set_pcf(adap, 1, I2C_PCF_ESO);
>> -		/* TODO: we should pause for a time period sufficient for any
>> -		 * running I2C transaction to complete-- the arbitration
>> -		 * logic won't work properly until the next START is seen.
>> -		 */
>> -		DEB2(printk(KERN_INFO
>> -			"i2c-algo-pcf.o: reset LAB condition (CSR 0x%02x)\n",
>> -			get_pcf(adap,1)));
>> +		handle_lab(adap, status);
>>  		return(-EINTR);
>>  	}
>>  #endif
>> @@ -218,9 +232,8 @@ static inline int try_address(struct i2c
>>  				break;	/* success! */
>>  			}
>>  		}
>> -		if (wfp == -EINTR) {
>> +		else if (wfp == -EINTR) {
>>  			/* arbitration lost */
>> -			udelay(adap->udelay);
>>  			return -EINTR;
>>  		}
>>  		i2c_stop(adap);
>> @@ -378,6 +393,10 @@ static int pcf_xfer(struct i2c_adapter *
>>  	/* Check for bus busy */
>>  	timeout = wait_for_bb(adap);
>>  	if (timeout) {
>> +		if (timeout == -EINTR) {
>> +			/* arbitration lost */
>> +			return -EINTR;
>> +		}
>>  		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
>>  		            "Timeout waiting for BB in pcf_xfer\n");)
>>  		return -EIO;
>> diff --git a/include/linux/i2c-algo-pcf.h b/include/linux/i2c-algo-pcf.h
>> index 994eb86..d11c141 100644
>> --- a/include/linux/i2c-algo-pcf.h
>> +++ b/include/linux/i2c-algo-pcf.h
>> @@ -36,6 +36,12 @@ struct i2c_algo_pcf_data {
>>  	/* local settings */
>>  	int udelay;
>>  	int timeout;
>> +
>> +	/* Multi-master lost arbitration back-off delay (msecs)
>> +	 * This should be set by the bus adapter or knowledgable client
>> +	 * if bus is multi-mastered, else zero
>> +	 */
>> +	unsigned long lab_mdelay;
>>  };
>>
>>  int i2c_pcf_add_bus(struct i2c_adapter *);
>
> As a side question, shouldn't i2c-algo-pcf retry, rather than fail, on
> arbitration lost?

It is not a safe assumption that a command (or series of commands) can
be re-tried after arbitration is lost.  A convenience function or
setting in the driver may be worthwhile for cases where the consumer
knows the action to be safe, but I would divorce such an enhancement
from this proposed patch.

>
> --
> Jean Delvare

Thank you again for your consideration.  Apologies for the tardiness of a reply.
-- 
E

------=_Part_959_20276858.1213305003589
Content-Type: text/plain; name=pcf_handle_lab_take2.patch.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhdu902p0
Content-Disposition: attachment; filename=pcf_handle_lab_take2.patch.txt

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2FsZ29zL2kyYy1hbGdvLXBjZi5jIGIvZHJpdmVycy9p
MmMvYWxnb3MvaTJjLWFsZ28tcGNmLmMKaW5kZXggZWNiMmMyZC4uNWI4ZTY4NiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9pMmMvYWxnb3MvaTJjLWFsZ28tcGNmLmMKKysrIGIvZHJpdmVycy9pMmMvYWxn
b3MvaTJjLWFsZ28tcGNmLmMKQEAgLTc4LDYgKzc4LDMxIEBAIHN0YXRpYyB2b2lkIGkyY19zdG9w
KHN0cnVjdCBpMmNfYWxnb19wY2YKIAlzZXRfcGNmKGFkYXAsIDEsIEkyQ19QQ0ZfU1RPUCk7CiB9
CiAKK3N0YXRpYyB2b2lkIGhhbmRsZV9sYWIoc3RydWN0IGkyY19hbGdvX3BjZl9kYXRhICphZGFw
LCBjb25zdCBpbnQgKnN0YXR1cykKK3sKKwlERUIyKHByaW50ayhLRVJOX0lORk8gCisJCSJpMmMt
YWxnby1wY2YubzogbG9zdCBhcmJpdHJhdGlvbiAoQ1NSIDB4JTAyeClcbiIsCisJCSAqc3RhdHVz
KSk7CisJLyogQ2xlYW51cCBmcm9tIExBQi0tIHJlc2V0IGFuZCBlbmFibGUgRVNPLgorCSAqIFRo
aXMgcmVzZXRzIHRoZSBQQ0Y4NTg0OyBzaW5jZSB3ZSd2ZSBsb3N0IHRoZSBidXMsIG5vCisJICog
ZnVydGhlciBhdHRlbXB0cyBzaG91bGQgYmUgbWFkZSBieSBjYWxsZXJzIHRvIGNsZWFuIHVwIAor
CSAqIChubyBpMmNfc3RvcCgpIGV0Yy4pCisJICovCisJc2V0X3BjZihhZGFwLCAxLCBJMkNfUENG
X1BJTik7CisJc2V0X3BjZihhZGFwLCAxLCBJMkNfUENGX0VTTyk7CisJLyogV2UgcGF1c2UgZm9y
IGEgdGltZSBwZXJpb2Qgc3VmZmljaWVudCBmb3IgYW55IHJ1bm5pbmcgCisJICogSTJDIHRyYW5z
YWN0aW9uIHRvIGNvbXBsZXRlLS0gdGhlIGFyYml0cmF0aW9uIGxvZ2ljIHdvbid0IAorCSAqIHdv
cmsgcHJvcGVybHkgdW50aWwgdGhlIG5leHQgU1RBUlQgaXMgc2Vlbi4KKwkgKiBJdCBpcyBhc3N1
bWVkIHRoZSBidXMgZHJpdmVyIG9yIGNsaWVudCBoYXMgc2V0IGEgcHJvcGVyIHZhbHVlLgorCSAq
LworCWlmIChhZGFwLT5sYWJfbWRlbGF5KSB7CisJCW1kZWxheShhZGFwLT5sYWJfbWRlbGF5KTsK
Kwl9CisJREVCMihwcmludGsoS0VSTl9JTkZPIAorCQkiaTJjLWFsZ28tcGNmLm86IHJlc2V0IExB
QiBjb25kaXRpb24gKENTUiAweCUwMngpXG4iLCAKKwkJZ2V0X3BjZihhZGFwLCAxKSkpOworfQor
CiBzdGF0aWMgaW50IHdhaXRfZm9yX2JiKHN0cnVjdCBpMmNfYWxnb19wY2ZfZGF0YSAqYWRhcCkg
ewogCiAJaW50IHRpbWVvdXQgPSBERUZfVElNRU9VVDsKQEAgLTEwOSwyMyArMTM0LDcgQEAgc3Rh
dGljIGludCB3YWl0X2Zvcl9waW4oc3RydWN0IGkyY19hbGdvXwogCQkqc3RhdHVzID0gZ2V0X3Bj
ZihhZGFwLCAxKTsKIAl9CiAJaWYgKCpzdGF0dXMgJiBJMkNfUENGX0xBQikgewotCQlERUIyKHBy
aW50ayhLRVJOX0lORk8gCi0JCQkiaTJjLWFsZ28tcGNmLm86IGxvc3QgYXJiaXRyYXRpb24gKENT
UiAweCUwMngpXG4iLAotCQkJICpzdGF0dXMpKTsKLQkJLyogQ2xlYW51cCBmcm9tIExBQi0tIHJl
c2V0IGFuZCBlbmFibGUgRVNPLgotCQkgKiBUaGlzIHJlc2V0cyB0aGUgUENGODU4NDsgc2luY2Ug
d2UndmUgbG9zdCB0aGUgYnVzLCBubwotCQkgKiBmdXJ0aGVyIGF0dGVtcHRzIHNob3VsZCBiZSBt
YWRlIGJ5IGNhbGxlcnMgdG8gY2xlYW4gdXAgCi0JCSAqIChubyBpMmNfc3RvcCgpIGV0Yy4pCi0J
CSAqLwotCQlzZXRfcGNmKGFkYXAsIDEsIEkyQ19QQ0ZfUElOKTsKLQkJc2V0X3BjZihhZGFwLCAx
LCBJMkNfUENGX0VTTyk7Ci0JCS8qIFRPRE86IHdlIHNob3VsZCBwYXVzZSBmb3IgYSB0aW1lIHBl
cmlvZCBzdWZmaWNpZW50IGZvciBhbnkKLQkJICogcnVubmluZyBJMkMgdHJhbnNhY3Rpb24gdG8g
Y29tcGxldGUtLSB0aGUgYXJiaXRyYXRpb24KLQkJICogbG9naWMgd29uJ3Qgd29yayBwcm9wZXJs
eSB1bnRpbCB0aGUgbmV4dCBTVEFSVCBpcyBzZWVuLgotCQkgKi8KLQkJREVCMihwcmludGsoS0VS
Tl9JTkZPIAotCQkJImkyYy1hbGdvLXBjZi5vOiByZXNldCBMQUIgY29uZGl0aW9uIChDU1IgMHgl
MDJ4KVxuIiwgCi0JCQlnZXRfcGNmKGFkYXAsMSkpKTsKKwkJaGFuZGxlX2xhYihhZGFwLCBzdGF0
dXMpOwogCQlyZXR1cm4oLUVJTlRSKTsKIAl9CiAjZW5kaWYKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvaTJjLWFsZ28tcGNmLmggYi9pbmNsdWRlL2xpbnV4L2kyYy1hbGdvLXBjZi5oCmluZGV4
IDk5NGViODYuLmQxMWMxNDEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaTJjLWFsZ28tcGNm
LmgKKysrIGIvaW5jbHVkZS9saW51eC9pMmMtYWxnby1wY2YuaApAQCAtMzYsNiArMzYsMTIgQEAg
c3RydWN0IGkyY19hbGdvX3BjZl9kYXRhIHsKIAkvKiBsb2NhbCBzZXR0aW5ncyAqLwogCWludCB1
ZGVsYXk7CiAJaW50IHRpbWVvdXQ7CisKKwkvKiBNdWx0aS1tYXN0ZXIgbG9zdCBhcmJpdHJhdGlv
biBiYWNrLW9mZiBkZWxheSAobXNlY3MpCisJICogVGhpcyBzaG91bGQgYmUgc2V0IGJ5IHRoZSBi
dXMgYWRhcHRlciBvciBrbm93bGVkZ2FibGUgY2xpZW50IAorCSAqIGlmIGJ1cyBpcyBtdWx0aS1t
YXN0ZXJlZCwgZWxzZSB6ZXJvCisJICovCisJdW5zaWduZWQgbG9uZyBsYWJfbWRlbGF5OwogfTsK
IAogaW50IGkyY19wY2ZfYWRkX2J1cyhzdHJ1Y3QgaTJjX2FkYXB0ZXIgKik7Cg==
------=_Part_959_20276858.1213305003589
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
------=_Part_959_20276858.1213305003589--
