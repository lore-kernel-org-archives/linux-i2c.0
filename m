From: Pablo Bitton <pablo.bitton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the bus
Date: Mon, 13 Sep 2010 16:23:00 +0200
Message-ID: <AANLkTimqT=xgoxycjFAwEr6LPTeK21-FB1F-7kP5baPE@mail.gmail.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
	<1264549293-25556-7-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1028932657=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1264549293-25556-7-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--===============1028932657==
Content-Type: multipart/alternative; boundary=001485e76f566df5ea049024d53b

--001485e76f566df5ea049024d53b
Content-Type: text/plain; charset=ISO-8859-1

Hi Philby,

On Wed, Jan 27, 2010 at 1:41 AM, Kevin Hilman
<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>wrote:

> From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
>
> Come out of i2c time out condition by following the
> bus recovery procedure outlined in the i2c protocol v3 spec.
> The kernel must be robust enough to gracefully recover
> from i2c bus failure without having to reset the machine.
> This is done by first NACKing the slave, pulsing the SCL
> line 9 times and then sending the stop command.
>
> This patch has been tested on a DM6446 and DM355
>
> Signed-off-by: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> Signed-off-by: Srinivasan, Nageswari <nageswari-l0cyMroinI0@public.gmane.org>
> Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-davinci.c |   57
> +++++++++++++++++++++++++++++++++++--
>  1 files changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c
> b/drivers/i2c/busses/i2c-davinci.c
> index 35f9daa..5459065 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -36,6 +36,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/cpufreq.h>
> +#include <linux/gpio.h>
>
>  #include <mach/hardware.h>
>  #include <mach/i2c.h>
> @@ -43,6 +44,7 @@
>  /* ----- global defines ----------------------------------------------- */
>
>  #define DAVINCI_I2C_TIMEOUT    (1*HZ)
> +#define DAVINCI_I2C_MAX_TRIES  2
>  #define I2C_DAVINCI_INTR_ALL    (DAVINCI_I2C_IMR_AAS | \
>                                 DAVINCI_I2C_IMR_SCD | \
>                                 DAVINCI_I2C_IMR_ARDY | \
> @@ -130,6 +132,44 @@ static inline u16 davinci_i2c_read_reg(struct
> davinci_i2c_dev *i2c_dev, int reg)
>        return __raw_readw(i2c_dev->base + reg);
>  }
>
> +/* Generate a pulse on the i2c clock pin. */
> +static void generic_i2c_clock_pulse(unsigned int scl_pin)
> +{
> +       u16 i;
> +
> +       if (scl_pin) {
> +               /* Send high and low on the SCL line */
> +               for (i = 0; i < 9; i++) {
> +                       gpio_set_value(scl_pin, 0);
> +                       udelay(20);
> +                       gpio_set_value(scl_pin, 1);
> +                       udelay(20);
> +               }
> +       }
> +}
> +
> +/* This routine does i2c bus recovery as specified in the
> + * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
> + */
> +static void i2c_recover_bus(struct davinci_i2c_dev *dev)
> +{
> +       u32 flag = 0;
> +       struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
> +
> +       dev_err(dev->dev, "initiating i2c bus recovery\n");
> +       /* Send NACK to the slave */
> +       flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> +       flag |=  DAVINCI_I2C_MDR_NACK;
> +       /* write the data into mode register */
> +       davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> +       if (pdata)
> +               generic_i2c_clock_pulse(pdata->scl_pin);
> +       /* Send STOP */
> +       flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> +       flag |= DAVINCI_I2C_MDR_STP;
> +       davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
> +}
> +
>  static inline void davinci_i2c_reset_ctrl(struct davinci_i2c_dev *i2c_dev,
>                                                                int val)
>  {
> @@ -235,14 +275,22 @@ static int i2c_davinci_wait_bus_not_busy(struct
> davinci_i2c_dev *dev,
>                                         char allow_sleep)
>  {
>        unsigned long timeout;
> +       static u16 to_cnt;
>
>        timeout = jiffies + dev->adapter.timeout;
>        while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
>               & DAVINCI_I2C_STR_BB) {
> -               if (time_after(jiffies, timeout)) {
> -                       dev_warn(dev->dev,
> -                                "timeout waiting for bus ready\n");
> -                       return -ETIMEDOUT;
> +               if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
> +                       if (time_after(jiffies, timeout)) {
> +                               dev_warn(dev->dev,
> +                               "timeout waiting for bus ready\n");
> +                               to_cnt++;
> +                               return -ETIMEDOUT;
> +                       } else {
> +                               to_cnt = 0;
> +                               i2c_recover_bus(dev);
> +                               i2c_davinci_init(dev);
> +                       }
>                }
>                if (allow_sleep)
>                        schedule_timeout(1);
>

The resulting loop has the following drawbacks:
1) If to_cnt reaches DAVINCI_I2C_MAX_TRIES+1 (which it currently can't, see
2) and the i2c bus collapses,
    the kernel will be stuck in the loop forever, especially if allow_sleep
is false.
2) The to_cnt static var never increments beyond 1. It's initialized to zero
and then kept at zero until the timeout expires.
    When the timeout expires, to_cnt is incremented once, until the next
call to the function, where it will be zeroed again.
 3) Do we really want to retry recovering the bus thousands of times, until
the timeout arrives?
    It seems to me that if the bus recovery procedure didn't help after one
or two tries, it probably never will.

I  also have the following nitpicks:
a) The timeout variable actually holds the finish time.
b) The i2c_recover_bus function uses dev_err to report a bus recovery
process,
    but if all recovery attempts failed and the timeout was reached, only
dev_warn is used to report the timeout.

Other than that the patch is very helpful, thanks a lot.

Below is my suggestion for the wait_bus_not_busy function. My patch has been
tested on a DM6446.

Signed-off-by: Pablo Bitton <pablo.bitton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--

diff --git a/drivers/i2c/busses/i2c-davinci.c
b/drivers/i2c/busses/i2c-davinci.c
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c

@@ -220,16 +261,24 @@ static int i2c_davinci_init(struct davinci_i2c_dev
*dev)
 static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
                               char allow_sleep)
 {
-     unsigned long timeout;
+     unsigned long finish_time;
+     unsigned long to_cnt = 0;

-     timeout = jiffies + dev->adapter.timeout;
+     finish_time = jiffies + dev->adapter.timeout;
+     /* While bus busy */
      while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
             & DAVINCI_I2C_STR_BB) {
-           if (time_after(jiffies, timeout)) {
+           if (time_after(jiffies, finish_time)) {
                  dev_warn(dev->dev,
                         "timeout waiting for bus ready\n");
                  return -ETIMEDOUT;
            }
+           else if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
+                 dev_warn(dev->dev, "bus busy, performing bus recovery\n");
+                   ++to_cnt;
+                       i2c_recover_bus(dev);
+                       i2c_davinci_init(dev);
+           }
            if (allow_sleep)
                  schedule_timeout(1);
      }

--001485e76f566df5ea049024d53b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Philby,<br><br>
<div class=3D"gmail_quote">On Wed, Jan 27, 2010 at 1:41 AM, Kevin Hilman <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org">khilman@=
deeprootsystems.com</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: rgb(204,204,204) 1px solid; MARGIN: 0pt 0=
pt 0pt 0.8ex; PADDING-LEFT: 1ex" class=3D"gmail_quote">From: Philby John &l=
t;<a href=3D"mailto:pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org" target=3D"_blank">pjohn-k0rHJ+Hhz/SVS+Kkd+ZcAg@public.gmane.org=
com</a>&gt;<br>
<br>Come out of i2c time out condition by following the<br>bus recovery pro=
cedure outlined in the i2c protocol v3 spec.<br>The kernel must be robust e=
nough to gracefully recover<br>from i2c bus failure without having to reset=
 the machine.<br>
This is done by first NACKing the slave, pulsing the SCL<br>line 9 times an=
d then sending the stop command.<br><br>This patch has been tested on a DM6=
446 and DM355<br><br>Signed-off-by: Philby John &lt;<a href=3D"mailto:pjohn=
@in.mvista.com" target=3D"_blank">pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org</a>&gt;<br>
Signed-off-by: Srinivasan, Nageswari &lt;<a href=3D"mailto:nageswari-l0cyMroinI0@public.gmane.org=
" target=3D"_blank">nageswari-l0cyMroinI0@public.gmane.org</a>&gt;<br>Acked-by: Kevin Hilman &lt;=
<a href=3D"mailto:khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org">khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org<=
/a>&gt;<br>
---<br>=A0drivers/i2c/busses/i2c-davinci.c | =A0 57 +++++++++++++++++++++++=
++++++++++++--<br>=A01 files changed, 53 insertions(+), 4 deletions(-)<br><=
br>diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-d=
avinci.c<br>
index 35f9daa..5459065 100644<br>--- a/drivers/i2c/busses/i2c-davinci.c<br>=
+++ b/drivers/i2c/busses/i2c-davinci.c<br>@@ -36,6 +36,7 @@<br>=A0#include =
&lt;linux/platform_device.h&gt;<br>=A0#include &lt;linux/io.h&gt;<br>=A0#in=
clude &lt;linux/cpufreq.h&gt;<br>
+#include &lt;linux/gpio.h&gt;<br><br>=A0#include &lt;mach/hardware.h&gt;<b=
r>=A0#include &lt;mach/i2c.h&gt;<br>@@ -43,6 +44,7 @@<br>=A0/* ----- global=
 defines ----------------------------------------------- */<br><br>=A0#defi=
ne DAVINCI_I2C_TIMEOUT =A0 =A0(1*HZ)<br>
+#define DAVINCI_I2C_MAX_TRIES =A02<br>=A0#define I2C_DAVINCI_INTR_ALL =A0 =
=A0(DAVINCI_I2C_IMR_AAS | \<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 DAVINCI_I2C_IMR_SCD | \<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DAVINCI_I2C_IMR_ARDY | \<br>@@ -130,6 +=
132,44 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2=
c_dev, int reg)<br>
=A0 =A0 =A0 =A0return __raw_readw(i2c_dev-&gt;base + reg);<br>=A0}<br><br>+=
/* Generate a pulse on the i2c clock pin. */<br>+static void generic_i2c_cl=
ock_pulse(unsigned int scl_pin)<br>+{<br>+ =A0 =A0 =A0 u16 i;<br>+<br>+ =A0=
 =A0 =A0 if (scl_pin) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Send high and low on the SCL line */<br>+ =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i &lt; 9; i++) {<br>+ =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(scl_pin, 0);<br>+ =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(20);<br>+ =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(scl_pin, 1);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(20);<br>+ =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 }<br>+ =A0 =A0 =A0 }<br>+}<br>+<br>+/* This routine does i2=
c bus recovery as specified in the<br>+ * i2c protocol Rev. 03 section 3.16=
 titled &quot;Bus clear&quot;<br>+ */<br>
+static void i2c_recover_bus(struct davinci_i2c_dev *dev)<br>+{<br>+ =A0 =
=A0 =A0 u32 flag =3D 0;<br>+ =A0 =A0 =A0 struct davinci_i2c_platform_data *=
pdata =3D dev-&gt;dev-&gt;platform_data;<br>+<br>+ =A0 =A0 =A0 dev_err(dev-=
&gt;dev, &quot;initiating i2c bus recovery\n&quot;);<br>
+ =A0 =A0 =A0 /* Send NACK to the slave */<br>+ =A0 =A0 =A0 flag =3D davinc=
i_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);<br>+ =A0 =A0 =A0 flag |=3D =A0DAV=
INCI_I2C_MDR_NACK;<br>+ =A0 =A0 =A0 /* write the data into mode register */=
<br>+ =A0 =A0 =A0 davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);<br=
>
+ =A0 =A0 =A0 if (pdata)<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 generic_i2c_clock=
_pulse(pdata-&gt;scl_pin);<br>+ =A0 =A0 =A0 /* Send STOP */<br>+ =A0 =A0 =
=A0 flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);<br>+ =A0 =A0 =
=A0 flag |=3D DAVINCI_I2C_MDR_STP;<br>+ =A0 =A0 =A0 davinci_i2c_write_reg(d=
ev, DAVINCI_I2C_MDR_REG, flag);<br>
+}<br>+<br>=A0static inline void davinci_i2c_reset_ctrl(struct davinci_i2c_=
dev *i2c_dev,<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =
val)<br>=A0{<br>@@ -235,14 +275,22 @@ static int i2c_davinci_wait_bus_not_b=
usy(struct davinci_i2c_dev *dev,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 char allow_sleep)<br>=A0{<br>=A0 =A0 =A0 =A0unsigned long timeout;<br>=
+ =A0 =A0 =A0 static u16 to_cnt;<br><br>=A0 =A0 =A0 =A0timeout =3D jiffies =
+ dev-&gt;adapter.timeout;<br>=A0 =A0 =A0 =A0while (davinci_i2c_read_reg(de=
v, DAVINCI_I2C_STR_REG)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp; DAVINCI_I2C_STR_BB) {<br>- =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 if (time_after(jiffies, timeout)) {<br>- =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev-&gt;dev,<br>- =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;timeout waiting for bus re=
ady\n&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;<br>+ =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 if (to_cnt &lt;=3D DAVINCI_I2C_MAX_TRIES) {<br>+ =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout=
)) {<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_w=
arn(dev-&gt;dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;timeout=
 waiting for bus ready\n&quot;);<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 to_cnt++;<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 } else {<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 to_cnt =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_recover_b=
us(dev);<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i=
2c_davinci_init(dev);<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (all=
ow_sleep)<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule_timeou=
t(1);<br>
</blockquote>
<div>
<div>=A0</div>
<div>The resulting loop=A0has the following drawbacks:</div>
<div>1) If to_cnt reaches DAVINCI_I2C_MAX_TRIES+1 (which it currently can&#=
39;t, see 2) and the i2c bus collapses,</div>
<div>=A0=A0=A0 the kernel will be stuck in the loop forever, especially if =
allow_sleep is false.</div>
<div>2) The to_cnt static var never increments beyond 1. It&#39;s initializ=
ed to zero and then kept at zero until the timeout expires.</div>
<div>=A0=A0=A0 When the timeout expires, to_cnt is incremented once, until =
the next call to the function, where it will be zeroed again.</div>
<div>=A03) Do we really want to retry recovering the bus thousands of times=
, until the timeout arrives?</div></div></div>
<div>=A0=A0=A0 It seems to me that if the bus recovery procedure didn&#39;t=
 help after one or two tries, it probably never will.</div>
<div></div>
<div>=A0</div>
<div>I=A0 also have the following nitpicks:</div>
<div>a) The timeout variable actually holds the finish time.</div>
<div>b) The i2c_recover_bus function uses dev_err to report a bus recovery =
process,</div>
<div>=A0=A0=A0 but if all recovery attempts failed and the timeout was reac=
hed, only dev_warn is used to report the timeout.</div>
<div></div>
<div>=A0</div>
<div>Other than that the patch is very helpful, thanks a lot.</div>
<div></div>
<div>=A0</div>
<div>Below is my suggestion for the wait_bus_not_busy function. My patch ha=
s been tested on a DM6446.</div>
<div></div>
<div>=A0</div>
<div>Signed-off-by:=A0Pablo Bitton=A0&lt;<a href=3D"mailto:pablo.bitton@gma=
il.com">pablo.bitton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</div>
<div>--</div>
<div>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><span style=3D"FONT=
-FAMILY: &#39;Courier New&#39;">diff --git a/drivers/i2c/busses/i2c-davinci=
.c b/drivers/i2c/busses/i2c-davinci.c<br>--- a/drivers/i2c/busses/i2c-davin=
ci.c<br>
+++ b/drivers/i2c/busses/i2c-davinci.c<br></span></p><br></div>
<p style=3D"MARGIN: 0in 0in 0pt" class=3D"MsoPlainText"><span style=3D"FONT=
-FAMILY: &#39;Courier New&#39;">@@ -220,16 +261,24 @@ static int i2c_davinc=
i_init(struct davinci_i2c_dev *dev)<br><span style=3D"mso-spacerun: yes">=
=A0</span>static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *=
dev,<br>
<span style=3D"mso-spacerun: yes">=A0</span><span style=3D"mso-tab-count: 5=
">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 </span><span style=3D"mso-spacerun: yes">=A0</span>char allow_=
sleep)<br><span style=3D"mso-spacerun: yes">=A0</span>{<br>-<span style=3D"=
mso-tab-count: 1">=A0=A0=A0=A0 </span>unsigned long timeout;<br>
+<span style=3D"mso-tab-count: 1">=A0=A0=A0=A0 </span>unsigned long finish_=
time;<br>+<span style=3D"mso-tab-count: 1">=A0=A0=A0=A0 </span>unsigned lon=
g to_cnt =3D 0;<br><span style=3D"mso-spacerun: yes">=A0</span><br>-<span s=
tyle=3D"mso-tab-count: 1">=A0=A0=A0=A0 </span>timeout =3D jiffies + dev-&gt=
;adapter.timeout;<br>
+<span style=3D"mso-tab-count: 1">=A0=A0=A0=A0 </span>finish_time =3D jiffi=
es + dev-&gt;adapter.timeout;<br>+<span style=3D"mso-tab-count: 1">=A0=A0=
=A0=A0 </span>/* While bus busy */<br><span style=3D"mso-spacerun: yes">=A0=
</span><span style=3D"mso-tab-count: 1">=A0=A0=A0=A0 </span>while (davinci_=
i2c_read_reg(dev, DAVINCI_I2C_STR_REG)<br>
<span style=3D"mso-spacerun: yes">=A0</span><span style=3D"mso-tab-count: 1=
">=A0=A0=A0=A0 </span><span style=3D"mso-spacerun: yes">=A0=A0=A0=A0=A0=A0 =
</span>&amp; DAVINCI_I2C_STR_BB) {<br>-<span style=3D"mso-tab-count: 2">=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>if (time_after(jiffies, timeout)) {<br>
+<span style=3D"mso-tab-count: 2">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>if =
(time_after(jiffies, finish_time)) {<br><span style=3D"mso-spacerun: yes">=
=A0</span><span style=3D"mso-tab-count: 1">=A0=A0=A0=A0 </span><span style=
=3D"mso-tab-count: 2">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>dev_warn(dev=
-&gt;dev,<br>
<span style=3D"mso-spacerun: yes">=A0</span><span style=3D"mso-tab-count: 4=
">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span=
><span style=3D"mso-spacerun: yes">=A0</span>&quot;timeout waiting for bus =
ready\n&quot;);<br><span style=3D"mso-spacerun: yes">=A0</span><span style=
=3D"mso-tab-count: 3">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </sp=
an>return -ETIMEDOUT;<br>
<span style=3D"mso-spacerun: yes">=A0</span><span style=3D"mso-tab-count: 2=
">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>}<br>+<span style=3D"mso-tab-count:=
 2">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>else if (to_cnt &lt;=3D DAVINCI_I=
2C_MAX_TRIES) {<br>+<span style=3D"mso-spacerun: yes">=A0=A0=A0=A0=A0=A0=A0=
 </span><span style=3D"mso-tab-count: 2">=A0=A0=A0=A0=A0=A0=A0=A0 </span>de=
v_warn(dev-&gt;dev, &quot;bus busy, performing bus recovery\n&quot;);<br>
+<span style=3D"mso-tab-count: 2">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><sp=
an style=3D"mso-spacerun: yes">=A0=A0=A0=A0=A0=A0=A0 </span>++to_cnt;<br>+<=
span style=3D"mso-tab-count: 4">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 </span>i2c_recover_bus(dev);<br>+<span style=3D"ms=
o-tab-count: 4">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 </span>i2c_davinci_init(dev);<br>
+<span style=3D"mso-tab-count: 2">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>}<b=
r><span style=3D"mso-spacerun: yes">=A0</span><span style=3D"mso-tab-count:=
 2">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>if (allow_sleep)<br><span style=
=3D"mso-spacerun: yes">=A0</span><span style=3D"mso-tab-count: 3">=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>schedule_timeout(1);<br>
<span style=3D"mso-spacerun: yes">=A0</span><span style=3D"mso-tab-count: 1=
">=A0=A0=A0=A0 </span>}<br></span></p></div>

--001485e76f566df5ea049024d53b--

--===============1028932657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1028932657==--
