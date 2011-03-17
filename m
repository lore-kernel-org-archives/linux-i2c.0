From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: Re: How to put extra clock cycles on i2c cavinci, problems on
 omapl138 (logic pd som)
Date: Thu, 17 Mar 2011 11:49:05 -0400
Message-ID: <AANLkTimN0RV4ECQJPZNxk752XGBdfNQFAUQ894syxbp6@mail.gmail.com>
References: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3@sewerin.de>
	<AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs@mail.gmail.com>
	<OFCCCD2C6E.D899BA32-ONC1257856.00307955-C1257856.00323B2B@sewerin.de>
	<AANLkTinAgDKe8GD5GQoKaJ3p2s1Pj_DWduEnp6deZu=f@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C30830A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C30830A-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org" <Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org" <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sekhar,

Thanks for rapidly weighing-in here.

On Thu, Mar 17, 2011 at 10:28 AM, Nori, Sekhar <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> On Thu, Mar 17, 2011 at 18:55:00, Ben Gardiner wrote:
>
>> I noticed on the e2e forums that there is a reason why the PSP uses =
a
>> bitbanging i2c interface -- since the 1.0v OPP makes the i2c
>> controller unusable [1] (I've added Sekhar to the CC since he pointe=
d
>> out the problem in that post).
>
> There was a problem with the way I2C was implemented on the SoM. Here=
 is
> the information I have for the modifications required on the SoM.
>
> "
> It is likely that the errors seen were a result of the buffer on the =
I2C clock. =A0The hardware fix for this issue is to remove U24 and R161=
 and short U24 pins 2 to 4.
> "
>
> There should be an EVM with these fixes already, though I have not
> tested it myself.
>
> Also, recently a bug in the I2C driver was brought to my attention.
> In the bus busy function:
>
> /*
> =A0* Waiting for bus not busy
> =A0*/
> static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 char allow_sleep)
> {
> =A0 =A0 =A0 =A0unsigned long timeout;
> =A0 =A0 =A0 =A0static u16 to_cnt;
>
> =A0 =A0 =A0 =A0timeout =3D jiffies + dev->adapter.timeout;
> =A0 =A0 =A0 =A0while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 & DAVINCI_I2C_STR_BB) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (to_cnt <=3D DAVINCI_I2C_MAX_TRIES)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(jiffies=
, timeout)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_wa=
rn(dev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"timeo=
ut waiting for bus ready\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0to_cnt=
++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 -ETIMEDOUT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0to_cnt=
 =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c_re=
cover_bus(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c_da=
vinci_init(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (allow_sleep)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule_timeout(1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> }
>
> If there is a context switch immediately after the while statement,
> the loop can return a timeout error while there is none. The
> simple solution would be to check for bus busy again if the
> timeout condition occurs. There should be a more elegant way
> to write the loop, but it is too late in the evening to think
> about it :)
>
> I doubt if this is related to the errors you guys are seeing,
> but it is worth trying anyway.

Thanks. I tried it (anyways) but there was no change in behaviour here
(diff attached).

I've posted to the e2e forum [1]. I hope it turns up some more info.

Best Regards,
Ben Gardiner

[1] http://e2e.ti.com/support/dsp/omap_applications_processors/f/42/p/9=
9895/350080.aspx

---
Nanometrics Inc.
http://www.nanometrics.ca

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-=
davinci.c
index 5795c83..ab8e0f3 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -44,7 +44,7 @@

 /* ----- global defines ----------------------------------------------=
- */

-#define DAVINCI_I2C_TIMEOUT    (1*HZ)
+#define DAVINCI_I2C_TIMEOUT    (2*HZ)
 #define DAVINCI_I2C_MAX_TRIES  2
 #define I2C_DAVINCI_INTR_ALL    (DAVINCI_I2C_IMR_AAS | \
                                 DAVINCI_I2C_IMR_SCD | \
@@ -282,7 +282,10 @@ static int i2c_davinci_wait_bus_not_busy(struct
davinci_i2c_dev *dev,
        while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
               & DAVINCI_I2C_STR_BB) {
                if (to_cnt <=3D DAVINCI_I2C_MAX_TRIES) {
-                       if (time_after(jiffies, timeout)) {
+                       if (time_after(jiffies, timeout)
+                               && (davinci_i2c_read_reg(dev,
+                                               DAVINCI_I2C_STR_REG)
+                                       & DAVINCI_I2C_STR_BB)) {
                                dev_warn(dev->dev,
                                "timeout waiting for bus ready\n");
                                to_cnt++;
