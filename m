From: Nitin Mahajan <nitinm76-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
Date: Wed, 22 Jul 2009 04:03:38 -0700 (PDT)
Message-ID: <218571.29671.qm@web50101.mail.re2.yahoo.com>
References: <1247643267.5981.82.camel@localhost.localdomain>
Reply-To: Nitin Mahajan <nitinm76-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1247643267.5981.82.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,=0A=0A=0A=0A----- Original Message ----=0A> From: Philby John <pjohn@=
in.mvista.com>=0A> To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=0A> Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org=
; davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org=0A> Sent: Wednesday, July =
15, 2009 13:04:27=0A> Subject: [PATCH/RFC 1/1] recover from davinci i2c tim=
e out conditions=0A> =0A> >From dbe7e824d576636bb15b82a20fd2557fddc9a8f7 Mo=
n Sep 17 00:00:00 2001=0A> From: Philby John =0A> Date: Tue, 14 Jul 2009 21=
:46:47 +0530=0A> Subject: [PATCH] Reset i2c bus to come out of time out con=
ditions=0A> =0A> Get out of i2c time out condition by resetting=0A> the i2c=
 bus. The kernel must be robust enough to=0A> gracefully recover from i2c b=
us failure without having=0A> to reset the machine. This is done by first N=
ACKing the slave=0A> and then resetting the i2c bus after a certain timeout=
.=0A> =0A> Signed-off-by: Philby John =0A=0AI tried this on DM6443 based bo=
ard with 2.6.18 kernel. The result I am posting below. It gives controller =
time out again and again.=0A=0Adhcppc9 login: i2c_davinci i2c_davinci.1: co=
ntroller timed out=0Ai2c_davinci i2c_davinci.1: initiating i2c bus recovery=
=0Ai2c_davinci i2c_davinci.1: controller timed out=0Ai2c_davinci i2c_davinc=
i.1: initiating i2c bus recovery=0Ai2c_davinci i2c_davinci.1: controller ti=
med out=0Ai2c_davinci i2c_davinci.1: initiating i2c bus recovery=0Ai2c_davi=
nci i2c_davinci.1: controller timed out=0Ai2c_davinci i2c_davinci.1: initia=
ting i2c bus recovery=0Ai2c_davinci i2c_davinci.1: controller timed out=0Ai=
2c_davinci i2c_davinci.1: initiating i2c bus recovery=0Ai2c_davinci i2c_dav=
inci.1: controller timed out=0Ai2c_davinci i2c_davinci.1: initiating i2c bu=
s recovery=0Ai2c_davinci i2c_davinci.1: controller timed out=0Ai2c_davinci =
i2c_davinci.1: initiating i2c bus recovery=0Ai2c_davinci i2c_davinci.1: con=
troller timed out=0Ai2c_davinci i2c_davinci.1: initiating i2c bus recovery=
=0Ai2c_davinci i2c_davinci.1: controller timed out=0Ai2c_davinci i2c_davinc=
i.1: initiating i2c bus recovery=0Ai2c_davinci i2c_davinci.1: controller ti=
med out=0Ai2c_davinci i2c_davinci.1: initiating i2c bus recovery=0Ai2c_davi=
nci i2c_davinci.1: controller timed out=0Ai2c_davinci i2c_davinci.1: initia=
ting i2c bus recovery=0A=0Aregards=0A=0A-Nitin=0A> ---=0A> drivers/i2c/buss=
es/i2c-davinci.c |   98 +++++++++++++++++++++++++++++++++++--=0A> 1 files c=
hanged, 92 insertions(+), 6 deletions(-)=0A> =0A> diff --git a/drivers/i2c/=
busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c=0A> index 17f2ee7..=
4ed1a4c 100755=0A> --- a/drivers/i2c/busses/i2c-davinci.c=0A> +++ b/drivers=
/i2c/busses/i2c-davinci.c=0A> @@ -35,14 +35,18 @@=0A> #include =0A> #includ=
e =0A> #include =0A> +#include =0A> =0A> #include =0A> =0A> #include =0A> +=
#include =0A> +#include =0A> =0A> /* ----- global defines -----------------=
------------------------------ */=0A> =0A> #define DAVINCI_I2C_TIMEOUT    (=
1*HZ)=0A> +#define DAVINCI_I2C_MAX_TRIES    2=0A> #define I2C_DAVINCI_INTR_=
ALL    (DAVINCI_I2C_IMR_AAS | \=0A>                  DAVINCI_I2C_IMR_SCD | =
\=0A>                  DAVINCI_I2C_IMR_ARDY | \=0A> @@ -135,6 +139,50 @@ st=
atic inline u16 davinci_i2c_read_reg(struct =0A> davinci_i2c_dev *i2c_dev, =
int reg)=0A> }=0A> =0A> /*=0A> + * Configure the i2c data pin as a GPIO inp=
ut and the i2c clock pin as a=0A> + * high GPIO output.=0A> + */=0A> +stati=
c void disable_i2c_pins(void)=0A> +{=0A> +    unsigned long flags;=0A> +=0A=
> +    local_irq_save(flags);=0A> +    if (cpu_is_davinci_dm355()) {=0A> + =
       gpio_direction_input(15);=0A> +        gpio_direction_output(14, 0);=
=0A> +        gpio_set_value(14, 1);=0A> +        davinci_cfg_reg(DM355_I2C=
_SDA);=0A> +        davinci_cfg_reg(DM355_I2C_SCL);=0A> +    }=0A> +    loc=
al_irq_restore(flags);=0A> +}=0A> +=0A> +/* Connect the i2c pins to the i2c=
 controller. */=0A> +static void enable_i2c_pins(void)=0A> +{=0A> +    unsi=
gned long flags;=0A> +=0A> +    local_irq_save(flags);=0A> +    if (cpu_is_=
davinci_dm355()) {=0A> +        davinci_cfg_reg(DM355_I2C_SDA);=0A> +      =
  davinci_cfg_reg(DM355_I2C_SCL);=0A> +    }=0A> +    local_irq_restore(fla=
gs);=0A> +}=0A> +=0A> +=0A> +/* Generate a pulse on the i2c clock pin. */=
=0A> +static void pulse_i2c_clock(void)=0A> +{=0A> +    if (cpu_is_davinci_=
dm355()) {=0A> +        gpio_set_value(14, 0);=0A> +        udelay(20);=0A>=
 +        gpio_set_value(14, 1);=0A> +        udelay(20);=0A> +    }=0A> +}=
=0A> +=0A> +/*=0A>   * This functions configures I2C and brings I2C out of =
reset.=0A>   * This function is called during I2C init function. This funct=
ion=0A>   * also gets called if I2C encounters any errors.=0A> @@ -221,14 +=
269,36 @@ static int i2c_davinci_wait_bus_not_busy(struct =0A> davinci_i2c_=
dev *dev,=0A>                      char allow_sleep)=0A> {=0A>     unsigned=
 long timeout;=0A> +    u16 i;=0A> +    static u16 to_cnt =3D 0;=0A> +    u=
32 flag =3D 0;=0A> =0A>     timeout =3D jiffies + dev->adapter.timeout;=0A>=
     while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)=0A> -           =
& DAVINCI_I2C_STR_BB) {=0A> -        if (time_after(jiffies, timeout)) {=0A=
> -            dev_warn(dev->dev,=0A> -                 "timeout waiting fo=
r bus ready\n");=0A> -            return -ETIMEDOUT;=0A> +            & DAV=
INCI_I2C_STR_BB) {=0A> +=0A> +        if (to_cnt <=3D DAVINCI_I2C_MAX_TRIES=
) {=0A> +            if (time_after(jiffies, timeout)) {=0A> +             =
   dev_warn(dev->dev,=0A> +                    "timeout waiting for bus rea=
dy\n");=0A> +                to_cnt++;=0A> +                return -ETIMEDO=
UT;=0A> +            }=0A> +        } else if (cpu_is_davinci_dm644x() || c=
pu_is_davinci_dm355()) {=0A> +            to_cnt =3D 0;=0A> +            de=
v_err(dev->dev, "initiating i2c bus recovery\n");=0A> +            /* Send =
the NACK to the slave */=0A> +            flag =3D davinci_i2c_read_reg(dev=
, DAVINCI_I2C_IMR_REG);=0A> +            flag |=3D  DAVINCI_I2C_MDR_NACK;=
=0A> +            /* write the data into mode register */=0A> +            =
davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);=0A> +            /* =
Disable i2c */=0A> +            disable_i2c_pins();=0A> +            for (i=
 =3D 0; i < 10; i++)=0A> +                pulse_i2c_clock();=0A> +         =
   /* Re-enable i2c */=0A> +            enable_i2c_pins();=0A> +           =
 i2c_davinci_init(dev);=0A>         }=0A>         if (allow_sleep)=0A>     =
        schedule_timeout(1);=0A> @@ -309,7 +379,23 @@ i2c_davinci_xfer_msg(=
struct i2c_adapter *adap, struct =0A> i2c_msg *msg, int stop)=0A>     r =3D=
 wait_for_completion_interruptible_timeout(&dev->cmd_complete,=0A>         =
                      dev->adapter.timeout);=0A>     if (r =3D=3D 0) {=0A> =
-        dev_err(dev->dev, "controller timed out\n");=0A> +        u16 i;=
=0A> +        u32 flag =3D 0;=0A> +        if (cpu_is_davinci_dm644x() || c=
pu_is_davinci_dm355()) {=0A> +            dev_err(dev->dev, "initiating i2c=
 bus recovery\n");=0A> +            /* Send the NACK to the slave */=0A> + =
           flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);=0A> +  =
          flag |=3D  DAVINCI_I2C_MDR_NACK;=0A> +            /* write the da=
ta into mode register */=0A> +            davinci_i2c_write_reg(dev, DAVINC=
I_I2C_MDR_REG, flag);=0A> +            /* Disable i2c */=0A> +            d=
isable_i2c_pins();=0A> +            /* Send high and low on the SCL line */=
=0A> +            for (i =3D 0; i < 10; i++)=0A> +                pulse_i2c=
_clock();=0A> +            /* Re-enable i2c */=0A> +            enable_i2c_=
pins();=0A> +        }=0A>         i2c_davinci_init(dev);=0A>         dev->=
buf_len =3D 0;=0A>         return -ETIMEDOUT;=0A> -- =0A> 1.6.3.3.MVISTA=0A=
> =0A> =0A> _______________________________________________=0A> Davinci-lin=
ux-open-source mailing list=0A> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi+G/Ez6ZCGd0@public.gmane.org=
com=0A> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-sou=
rce=0A=0A=0A=0A      New Email addresses available on Yahoo!=0AGet the Emai=
l name you&#39;ve always wanted on the new @ymail and @rocketmail. =0AHurry=
 before someone else does!=0Ahttp://mail.promotions.yahoo.com/newdomains/aa=
/
