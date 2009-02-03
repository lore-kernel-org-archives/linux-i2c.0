From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] i2c,algo: cleanup i2c-algo-pcf.c
Date: Tue, 03 Feb 2009 13:31:52 +0100
Message-ID: <49883938.9010104@gmail.com>
References: <4984688B.2090805@gmail.com>	<20090201114121.6448a3c9@hyperion.delvare>	<498760F7.6020005@gmail.com> <20090202225309.359e77d6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090202225309.359e77d6-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> On Mon, 02 Feb 2009 22:09:11 +0100, Roel Kluin wrote:
>> Jean Delvare wrote:
>>> Hi Roel,
>>>
>>> On Sat, 31 Jan 2009 16:04:43 +0100, Roel Kluin wrote:
>>>> The postfix decrement decrements timeout till -1, but the
>>>> warning is already triggered on 0
>>>>
>>>> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>> diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/=
i2c-algo-pcf.c
>>>> index 3e01992..0e2933f 100644
>>>> --- a/drivers/i2c/algos/i2c-algo-pcf.c
>>>> +++ b/drivers/i2c/algos/i2c-algo-pcf.c
>>>> @@ -115,7 +115,7 @@ static int wait_for_bb(struct i2c_algo_pcf_dat=
a *adap) {
>>>> =20
>>>>  	status =3D get_pcf(adap, 1);
>>>>  #ifndef STUB_I2C
>>>> -	while (timeout-- && !(status & I2C_PCF_BB)) {
>>>> +	while (--timeout && !(status & I2C_PCF_BB)) {
>>>>  		udelay(100); /* wait for 100 us */
>>>>  		status =3D get_pcf(adap, 1);
>>>>  	}
>>>> @@ -123,7 +123,7 @@ static int wait_for_bb(struct i2c_algo_pcf_dat=
a *adap) {
>>>>  	if (timeout <=3D 0) {
>>>>  		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
>>>>  	}
>>>> -=09
>>>> +
>>>>  	return (timeout<=3D0);
>>>>  }
>>> Never include unrelated whitespace cleanups in patches which fix bu=
gs.
>> I thought it was nice in this case, since it shows where things go w=
rong.
>=20
> If you really want to show this, feel free to increase the patch
> context. But in general, people can go read the original source file =
if
> they have to (which is what I did.)
>=20
>> Also I think it is generally considered wrong only if it affects cod=
e
>> that are in totally different sections - because it confuses, which =
it
>> does not if it's in the same section.
>=20
> I tend to believe that it becomes confusing as soon as it creates an
> additional hunk in the patch. It also increases the risk of patch
> rejection when one ports the fix to a different tree.
>=20
>>>> @@ -134,7 +134,7 @@ static int wait_for_pin(struct i2c_algo_pcf_da=
ta *adap, int *status) {
>>>> =20
>>>>  	*status =3D get_pcf(adap, 1);
>>>>  #ifndef STUB_I2C
>>>> -	while (timeout-- && (*status & I2C_PCF_PIN)) {
>>>> +	while (--timeout && (*status & I2C_PCF_PIN)) {
>>>>  		adap->waitforpin(adap->data);
>>>>  		*status =3D get_pcf(adap, 1);
>>>>  	}
>>> Not as critical as the ones in i2c-amd8111 and i2c-pxa, but still b=
ugs,
>>> I agree. I am, however, not totally happy with your fix. Leaving th=
e
>>> "<=3D 0" tests while the timeout will now stop at 0 is confusing. I=
 think
>>> you should change these tests to "=3D=3D 0". Other odd things in th=
ese
>>> functions:
>> I consider the "<=3D 0" test to be safer considering possible future
>> changes.
>=20
> Do you realize that this is exactly the kind of thinking which in the
> first place led to the bug you're fixing?

I disagree. It made it as harmless as it was. If there is a '=3D=3D 0' =
test,
while the result is -1, there will be no printk, and a return as if
everything is ok, while it is not. Such bugs are hard to catch.
=20
>>> * The timeout decrement should be _after_ the status test, otherwis=
e
>>>   you can exit with a timeout while the status was correct.
>> I agree, fixed in the patch below
>>
>>> * Mixing actual error codes (-EINTR) with arbitrary negative error
>>>   values (-1) isn't wise. We are lucky than EINTR isn't equal to 1.=
 I
>>>   think it would be better to return -ETIMEDOUT for timeouts rather
>>>   than an arbitrary number.
>> Also fixed (for both functions).
>>
>> Also I noted that in wait_for_pin() on a timeout, dependent on the
>> status, still a handle_lab(adap, status) and return -EINTR may occur=
,
>> which I think are wrong.
>=20
> Depends on the hardware implementation. If I2C_PCF_LAB can be set whi=
le
> I2C_PCF_PIN is set then indeed this is wrong. But I suspect the
> hardware is such that I2C_PCF_LAB can't be set without I2C_PCF_PIN
> being clear. You'd have to check the PCF8584 datasheet to make sure.

Regardless of the hardware implementation, if there is a timeout, that
is a reason to return -ETIMEDOUT, we can test later if not. That is the
sensible order in my opinion.

>>> Could you please submit a new patch fixing all the above?
>>>
>>> Thanks,
>> here it is:
>>
>> ---------------------------->8----------------8<--------------------=
----------
>> * Fix that the warning was already triggered on 0, which was not yet=
 a timeout.
>> * Move timeout decrement after the status test so that we don't exit=
 with a
>> timeout while the status was correct.
>> * Replace arbitrary values with error codes: return -ETIMEDOUT; upon=
 timeout.=20
>> * Ensure that upon a timeout we do not handle dependent on the last =
status.
>> * Local whitespace cleanups.
>>
>> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/i2c/algos/i2c-algo-pcf.c |   41 ++++++++++++++++-----------=
----------
>>  1 files changed, 18 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2=
c-algo-pcf.c
>> index 3e01992..05f0f56 100644
>> --- a/drivers/i2c/algos/i2c-algo-pcf.c
>> +++ b/drivers/i2c/algos/i2c-algo-pcf.c
>> @@ -108,45 +108,40 @@ static void handle_lab(struct i2c_algo_pcf_dat=
a *adap, const int *status)
>>  		get_pcf(adap, 1)));
>>  }
>> =20
>> -static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
>> -
>> +static int wait_for_bb(struct i2c_algo_pcf_data *adap)
>> +{
>> +#ifndef STUB_I2C
>=20
> As a side note, I think it's about time to get rid of STUB_I2C, as it
> is totally undocumented and at first sight it doesn't seem terribly
> useful anymore (if it ever was).
>=20
>>  	int timeout =3D DEF_TIMEOUT;
>> -	int status;
>> =20
>> -	status =3D get_pcf(adap, 1);
>> -#ifndef STUB_I2C
>> -	while (timeout-- && !(status & I2C_PCF_BB)) {
>> +	while (!(get_pcf(adap, 1) & I2C_PCF_BB) && --timeout)
>>  		udelay(100); /* wait for 100 us */
>> -		status =3D get_pcf(adap, 1);
>> -	}
>> -#endif
>> +
>>  	if (timeout <=3D 0) {
>>  		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
>> +		return -ETIMEDOUT;
>>  	}
>> -=09
>> -	return (timeout<=3D0);
>> +#endif
>> +	return 0;
>>  }
>> =20
>> =20
>> -static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status=
) {
>> -
>> +static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status=
)
>> +{
>> +#ifndef STUB_I2C
>>  	int timeout =3D DEF_TIMEOUT;
>> =20
>> -	*status =3D get_pcf(adap, 1);
>> -#ifndef STUB_I2C
>=20
> As long as STUB_I2C is there, the above is incorrect, as you will
> return 0 with *status unset. I would like to suggest that we go with =
2
> patches, one removing STUB_I2C and fixing any coding style issue you
> like, and a second one with the actual logic fixes.

You are right, thanks.

>> -	while (timeout-- && (*status & I2C_PCF_PIN)) {
>> +	while ((*status =3D get_pcf(adap, 1)) & I2C_PCF_PIN && --timeout)
>=20
> This lacks parentheses. Also, you'll get a warning from checkpatch fo=
r
> this construct (not sure if we care.)
>=20
>>  		adap->waitforpin(adap->data);
>> -		*status =3D get_pcf(adap, 1);
>> -	}
>> +
>> +	if (timeout <=3D 0)
>> +		return -ETIMEDOUT;
>> +
>>  	if (*status & I2C_PCF_LAB) {
>>  		handle_lab(adap, status);
>> -		return(-EINTR);
>> +		return -EINTR;
>>  	}
>>  #endif
>> -	if (timeout <=3D 0)
>> -		return(-1);
>> -	else
>> -		return(0);
>> +	return 0;
>>  }
>> =20
>>  /*=20
>=20
>=20

cleanup whitespace, fix comments and remove the unused STUB_I2C.

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-a=
lgo-pcf.c
index 3e01992..47c6266 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -1,31 +1,30 @@
-/* -------------------------------------------------------------------=
------ */
-/* i2c-algo-pcf.c i2c driver algorithms for PCF8584 adapters		     */
-/* -------------------------------------------------------------------=
------ */
-/*   Copyright (C) 1995-1997 Simon G. Vogl
-                   1998-2000 Hans Berglund
-
-    This program is free software; you can redistribute it and/or modi=
fy
-    it under the terms of the GNU General Public License as published =
by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
-/* -------------------------------------------------------------------=
------ */
-
-/* With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org> =
and
-   Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> ,and also from Martin Bailey
-   <mbailey-0IcqLCOdkweesDZOCDqTHtBPR1lH4CV8@public.gmane.org> */
-
-/* Partially rewriten by Oleg I. Vdovikin <vdovikin-EllQnLNTEGo@public.gmane.org> to handle=
 multiple
-   messages, proper stop/repstart signaling during receive,
-   added detect code */
+/*
+ * i2c-algo-pcf.c i2c driver algorithms for PCF8584 adapters
+ *
+ *   Copyright (C) 1995-1997 Simon G. Vogl
+ *		   1998-2000 Hans Berglund
+ *
+ *  This program is free software; you can redistribute it and/or modi=
fy
+ *  it under the terms of the GNU General Public License as published =
by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * With some changes from Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org> =
and
+ * Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, and also from Martin Bailey
+ * <mbailey-0IcqLCOdkweesDZOCDqTHtBPR1lH4CV8@public.gmane.org>
+ *
+ * Partially rewriten by Oleg I. Vdovikin <vdovikin-EllQnLNTEGo@public.gmane.org> to handle=
 multiple
+ * messages, proper stop/repstart signaling during receive, added dete=
ct code
+ */
=20
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -38,17 +37,18 @@
 #include "i2c-algo-pcf.h"
=20
=20
-#define DEB2(x) if (i2c_debug>=3D2) x
-#define DEB3(x) if (i2c_debug>=3D3) x /* print several statistical val=
ues*/
-#define DEBPROTO(x) if (i2c_debug>=3D9) x;
- 	/* debug the protocol by showing transferred bits */
+#define DEB2(x) if (i2c_debug >=3D 2) x
+#define DEB3(x) if (i2c_debug >=3D 3) x /* print several statistical v=
alues */
+#define DEBPROTO(x) if (i2c_debug >=3D 9) x;
+	/* debug the protocol by showing transferred bits */
 #define DEF_TIMEOUT 16
=20
-/* module parameters:
+/*
+ * module parameters:
  */
 static int i2c_debug;
=20
-/* --- setting states on the bus with the right timing: --------------=
-	*/
+/* setting states on the bus with the right timing: */
=20
 #define set_pcf(adap, ctl, val) adap->setpcf(adap->data, ctl, val)
 #define get_pcf(adap, ctl) adap->getpcf(adap->data, ctl)
@@ -57,22 +57,21 @@ static int i2c_debug;
 #define i2c_outb(adap, val) adap->setpcf(adap->data, 0, val)
 #define i2c_inb(adap) adap->getpcf(adap->data, 0)
=20
-/* --- other auxiliary functions -------------------------------------=
-	*/
+/* other auxiliary functions */
=20
-static void i2c_start(struct i2c_algo_pcf_data *adap)=20
+static void i2c_start(struct i2c_algo_pcf_data *adap)
 {
 	DEBPROTO(printk("S "));
 	set_pcf(adap, 1, I2C_PCF_START);
 }
=20
-static void i2c_repstart(struct i2c_algo_pcf_data *adap)=20
+static void i2c_repstart(struct i2c_algo_pcf_data *adap)
 {
 	DEBPROTO(printk(" Sr "));
 	set_pcf(adap, 1, I2C_PCF_REPSTART);
 }
=20
-
-static void i2c_stop(struct i2c_algo_pcf_data *adap)=20
+static void i2c_stop(struct i2c_algo_pcf_data *adap)
 {
 	DEBPROTO(printk("P\n"));
 	set_pcf(adap, 1, I2C_PCF_STOP);
@@ -82,17 +81,17 @@ static void handle_lab(struct i2c_algo_pcf_data *ad=
ap, const int *status)
 {
 	DEB2(printk(KERN_INFO
 		"i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
-		 *status));
-
-	/* Cleanup from LAB -- reset and enable ESO.
+		*status));
+	/*
+	 * Cleanup from LAB -- reset and enable ESO.
 	 * This resets the PCF8584; since we've lost the bus, no
 	 * further attempts should be made by callers to clean up
 	 * (no i2c_stop() etc.)
 	 */
 	set_pcf(adap, 1, I2C_PCF_PIN);
 	set_pcf(adap, 1, I2C_PCF_ESO);
-
-	/* We pause for a time period sufficient for any running
+	/*
+	 * We pause for a time period sufficient for any running
 	 * I2C transaction to complete -- the arbitration logic won't
 	 * work properly until the next START is seen.
 	 * It is assumed the bus driver or client has set a proper value.
@@ -108,48 +107,48 @@ static void handle_lab(struct i2c_algo_pcf_data *=
adap, const int *status)
 		get_pcf(adap, 1)));
 }
=20
-static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
+static int wait_for_bb(struct i2c_algo_pcf_data *adap)
+{
=20
 	int timeout =3D DEF_TIMEOUT;
 	int status;
=20
 	status =3D get_pcf(adap, 1);
-#ifndef STUB_I2C
+
 	while (timeout-- && !(status & I2C_PCF_BB)) {
 		udelay(100); /* wait for 100 us */
 		status =3D get_pcf(adap, 1);
 	}
-#endif
-	if (timeout <=3D 0) {
+
+	if (timeout <=3D 0)
 		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
-	}
-=09
-	return (timeout<=3D0);
-}
=20
+	return timeout <=3D 0;
+}
=20
-static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status) {
+static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status)
+{
=20
 	int timeout =3D DEF_TIMEOUT;
=20
 	*status =3D get_pcf(adap, 1);
-#ifndef STUB_I2C
+
 	while (timeout-- && (*status & I2C_PCF_PIN)) {
 		adap->waitforpin(adap->data);
 		*status =3D get_pcf(adap, 1);
 	}
 	if (*status & I2C_PCF_LAB) {
 		handle_lab(adap, status);
-		return(-EINTR);
+		return -EINTR;
 	}
-#endif
+
 	if (timeout <=3D 0)
-		return(-1);
+		return -1;
 	else
-		return(0);
+		return 0;
 }
=20
-/*=20
+/*
  * This should perform the 'PCF8584 initialization sequence' as descri=
bed
  * in the Philips IC12 data book (1995, Aug 29).
  * There should be a 30 clock cycle wait after reset, I assume this
@@ -164,18 +163,21 @@ static int pcf_init_8584 (struct i2c_algo_pcf_dat=
a *adap)
 {
 	unsigned char temp;
=20
-	DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: PCF state 0x%02x\n", get_pcf(=
adap, 1)));
+	DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: PCF state 0x%02x\n",
+				get_pcf(adap, 1)));
=20
 	/* S1=3D0x80: S0 selected, serial interface off */
 	set_pcf(adap, 1, I2C_PCF_PIN);
-	/* check to see S1 now used as R/W ctrl -
-	   PCF8584 does that when ESO is zero */
+	/*
+	 * check to see S1 now used as R/W ctrl -
+	 * PCF8584 does that when ESO is zero
+	 */
 	if (((temp =3D get_pcf(adap, 1)) & 0x7f) !=3D (0)) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't =
select S0 (0x%02x).\n", temp));
 		return -ENXIO; /* definetly not PCF8584 */
 	}
=20
-	/* load own address in S0, effective address is (own << 1)	*/
+	/* load own address in S0, effective address is (own << 1) */
 	i2c_outb(adap, get_own(adap));
 	/* check it's really written */
 	if ((temp =3D i2c_inb(adap)) !=3D get_own(adap)) {
@@ -183,7 +185,7 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data =
*adap)
 		return -ENXIO;
 	}
=20
-	/* S1=3D0xA0, next byte in S2					*/
+	/* S1=3D0xA0, next byte in S2 */
 	set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
 	/* check to see S2 now selected */
 	if (((temp =3D get_pcf(adap, 1)) & 0x7f) !=3D I2C_PCF_ES1) {
@@ -191,7 +193,7 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data =
*adap)
 		return -ENXIO;
 	}
=20
-	/* load clock register S2					*/
+	/* load clock register S2 */
 	i2c_outb(adap, get_clock(adap));
 	/* check it's really written, the only 5 lowest bits does matter */
 	if (((temp =3D i2c_inb(adap)) & 0x1f) !=3D get_clock(adap)) {
@@ -199,7 +201,7 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data =
*adap)
 		return -ENXIO;
 	}
=20
-	/* Enable serial interface, idle, S0 selected			*/
+	/* Enable serial interface, idle, S0 selected */
 	set_pcf(adap, 1, I2C_PCF_IDLE);
=20
 	/* check to see PCF is really idled and we can access status register=
 */
@@ -207,57 +209,47 @@ static int pcf_init_8584 (struct i2c_algo_pcf_dat=
a *adap)
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't =
select S1` (0x%02x).\n", temp));
 		return -ENXIO;
 	}
-=09
+
 	printk(KERN_DEBUG "i2c-algo-pcf.o: detected and initialized PCF8584.\=
n");
=20
 	return 0;
 }
=20
-
-/* ----- Utility functions
- */
-
 static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf=
,
-                         int count, int last)
+			 int count, int last)
 {
 	struct i2c_algo_pcf_data *adap =3D i2c_adap->algo_data;
 	int wrcount, status, timeout;
-   =20
+
 	for (wrcount=3D0; wrcount<count; ++wrcount) {
 		DEB2(dev_dbg(&i2c_adap->dev, "i2c_write: writing %2.2X\n",
-				buf[wrcount]&0xff));
+				buf[wrcount] & 0xff));
 		i2c_outb(adap, buf[wrcount]);
 		timeout =3D wait_for_pin(adap, &status);
 		if (timeout) {
-			if (timeout =3D=3D -EINTR) {
-				/* arbitration lost */
-				return -EINTR;
-			}
+			if (timeout =3D=3D -EINTR)
+				return -EINTR; /* arbitration lost */
+
 			i2c_stop(adap);
 			dev_err(&i2c_adap->dev, "i2c_write: error - timeout.\n");
 			return -EREMOTEIO; /* got a better one ?? */
 		}
-#ifndef STUB_I2C
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
 			dev_err(&i2c_adap->dev, "i2c_write: error - no ack.\n");
 			return -EREMOTEIO; /* got a better one ?? */
 		}
-#endif
 	}
-	if (last) {
+	if (last)
 		i2c_stop(adap);
-	}
-	else {
+	else
 		i2c_repstart(adap);
-	}
=20
-	return (wrcount);
+	return wrcount;
 }
=20
-
 static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
-                         int count, int last)
+			 int count, int last)
 {
 	int i, status;
 	struct i2c_algo_pcf_data *adap =3D i2c_adap->algo_data;
@@ -267,42 +259,36 @@ static int pcf_readbytes(struct i2c_adapter *i2c_=
adap, char *buf,
 	for (i =3D 0; i <=3D count; i++) {
=20
 		if ((wfp =3D wait_for_pin(adap, &status))) {
-			if (wfp =3D=3D -EINTR) {
-				/* arbitration lost */
-				return -EINTR;
-			}
+			if (wfp =3D=3D -EINTR)
+				return -EINTR; /* arbitration lost */
+
 			i2c_stop(adap);
 			dev_err(&i2c_adap->dev, "pcf_readbytes timed out.\n");
-			return (-1);
+			return -1;
 		}
=20
-#ifndef STUB_I2C
 		if ((status & I2C_PCF_LRB) && (i !=3D count)) {
 			i2c_stop(adap);
 			dev_err(&i2c_adap->dev, "i2c_read: i2c_inb, No ack.\n");
-			return (-1);
+			return -1;
 		}
-#endif
-	=09
+
 		if (i =3D=3D count - 1) {
 			set_pcf(adap, 1, I2C_PCF_ESO);
-		} else=20
-		if (i =3D=3D count) {
-			if (last) {
+		} else if (i =3D=3D count) {
+			if (last)
 				i2c_stop(adap);
-			} else {
+			else
 				i2c_repstart(adap);
-			}
-		};
+		}
=20
-		if (i) {
+		if (i)
 			buf[i - 1] =3D i2c_inb(adap);
-		} else {
+		else
 			i2c_inb(adap); /* dummy read */
-		}
 	}
=20
-	return (i - 1);
+	return i - 1;
 }
=20
=20
@@ -313,24 +299,26 @@ static int pcf_doAddress(struct i2c_algo_pcf_data=
 *adap,
 	unsigned char addr;
=20
 	addr =3D msg->addr << 1;
+
 	if (flags & I2C_M_RD)
 		addr |=3D 1;
 	if (flags & I2C_M_REV_DIR_ADDR)
 		addr ^=3D 1;
+
 	i2c_outb(adap, addr);
=20
 	return 0;
 }
=20
 static int pcf_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg *msgs,=20
+		    struct i2c_msg *msgs,
 		    int num)
 {
 	struct i2c_algo_pcf_data *adap =3D i2c_adap->algo_data;
 	struct i2c_msg *pmsg;
 	int i;
 	int ret=3D0, timeout, status;
-   =20
+
 	if (adap->xfer_begin)
 		adap->xfer_begin(adap->data);
=20
@@ -338,25 +326,24 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 	timeout =3D wait_for_bb(adap);
 	if (timeout) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
-		            "Timeout waiting for BB in pcf_xfer\n");)
+			    "Timeout waiting for BB in pcf_xfer\n");)
 		i =3D -EIO;
 		goto out;
 	}
-=09
+
 	for (i =3D 0;ret >=3D 0 && i < num; i++) {
 		pmsg =3D &msgs[i];
=20
 		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x =
- %d of %d messages\n",
 		     pmsg->flags & I2C_M_RD ? "read" : "write",
-                     pmsg->len, pmsg->addr, i + 1, num);)
-   =20
+		     pmsg->len, pmsg->addr, i + 1, num);)
+
 		ret =3D pcf_doAddress(adap, pmsg);
=20
 		/* Send START */
-		if (i =3D=3D 0) {
-			i2c_start(adap);=20
-		}
-   =20
+		if (i =3D=3D 0)
+			i2c_start(adap);
+
 		/* Wait for PIN (pending interrupt NOT) */
 		timeout =3D wait_for_pin(adap, &status);
 		if (timeout) {
@@ -371,8 +358,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 			i =3D -EREMOTEIO;
 			goto out;
 		}
-   =20
-#ifndef STUB_I2C
+
 		/* Check LRB (last rcvd bit - slave ack) */
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
@@ -380,57 +366,53 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 			i =3D -EREMOTEIO;
 			goto out;
 		}
-#endif
-   =20
+
 		DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: Msg %d, addr=3D0x%x, flags=3D=
0x%x, len=3D%d\n",
 			    i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
-   =20
-		/* Read */
+
 		if (pmsg->flags & I2C_M_RD) {
-			/* read bytes into buffer*/
 			ret =3D pcf_readbytes(i2c_adap, pmsg->buf, pmsg->len,
-                                            (i + 1 =3D=3D num));
-       =20
-			if (ret !=3D pmsg->len) {
+					    (i + 1 =3D=3D num));
+
+			if (ret !=3D pmsg->len)
 				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
 					    "only read %d bytes.\n",ret));
-			} else {
+			else
 				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n",ret));
-			}
-		} else { /* Write */
+
+		} else {
 			ret =3D pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
-                                            (i + 1 =3D=3D num));
-       =20
-			if (ret !=3D pmsg->len) {
+					    (i + 1 =3D=3D num));
+
+			if (ret !=3D pmsg->len)
 				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
 					    "only wrote %d bytes.\n",ret));
-			} else {
+			else
 				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n",ret));
-			}
+
 		}
 	}
=20
 out:
 	if (adap->xfer_end)
 		adap->xfer_end(adap->data);
-	return (i);
+	return i;
 }
=20
 static u32 pcf_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |=20
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
 	       I2C_FUNC_PROTOCOL_MANGLING;
 }
=20
-/* -----exported algorithm data: -------------------------------------=
	*/
-
+/* exported algorithm data: */
 static const struct i2c_algorithm pcf_algo =3D {
 	.master_xfer	=3D pcf_xfer,
 	.functionality	=3D pcf_func,
 };
=20
-/*=20
- * registering functions to load algorithms at runtime=20
+/*
+ * registering functions to load algorithms at runtime
  */
 int i2c_pcf_add_bus(struct i2c_adapter *adap)
 {
@@ -458,4 +440,4 @@ MODULE_LICENSE("GPL");
=20
 module_param(i2c_debug, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(i2c_debug,
-        "debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protoc=
ol");
+	"debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protocol");
