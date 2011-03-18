From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: How to put extra clock cycles on i2c cavinci, problems on
 omapl138 (logic pd som)
Date: Fri, 18 Mar 2011 14:23:21 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C3B843B@dbde02.ent.ti.com>
References: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3@sewerin.de>
	<AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs@mail.gmail.com>
	<OFCCCD2C6E.D899BA32-ONC1257856.00307955-C1257856.00323B2B@sewerin.de>
 <AANLkTinAgDKe8GD5GQoKaJ3p2s1Pj_DWduEnp6deZu=f@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C30830A@dbde02.ent.ti.com>
 <OFDFF6C831.8C9C5CF9-ONC1257857.0023FBF9-C1257857.0024F492@sewerin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <OFDFF6C831.8C9C5CF9-ONC1257857.0023FBF9-C1257857.0024F492-qHSRieSIjQqELgA04lAiVw@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org" <Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org>
Cc: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org" <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Bastian,

On Fri, Mar 18, 2011 at 12:13:31, Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org wrote:
> Dear Sekhar,
> 
> > 
> > RE: How to put extra clock cycles on i2c cavinci, problems on 
> > omapl138 (logic pd som)
> > 
> > On Thu, Mar 17, 2011 at 18:55:00, Ben Gardiner wrote:
> > 
> > > I noticed on the e2e forums that there is a reason why the PSP uses a
> > > bitbanging i2c interface -- since the 1.0v OPP makes the i2c
> > > controller unusable [1] (I've added Sekhar to the CC since he pointed
> > > out the problem in that post).
> > 
> > There was a problem with the way I2C was implemented on the SoM. Here is
> > the information I have for the modifications required on the SoM.
> > 
> > "
> > It is likely that the errors seen were a result of the buffer on the
> > I2C clock.  The hardware fix for this issue is to remove U24 and 
> > R161 and short U24 pins 2 to 4.
> > "
> 
> I have a hardware here without this buffer in the I2C clock wire!

Okay. So, I guess the two issues have different root causes.

>  
> > There should be an EVM with these fixes already, though I have not
> > tested it myself.
> > 
> > Also, recently a bug in the I2C driver was brought to my attention.
> > In the bus busy function:
> > 
> > /*
> >  * Waiting for bus not busy
> >  */
> > static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
> >                 char allow_sleep)
> > {
> >    unsigned long timeout;
> >    static u16 to_cnt;
> > 
> >    timeout = jiffies + dev->adapter.timeout;
> >    while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
> >           & DAVINCI_I2C_STR_BB) {
> >       if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
> >          if (time_after(jiffies, timeout)) {
> >             dev_warn(dev->dev,
> >             "timeout waiting for bus ready\n");
> >             to_cnt++;
> >             return -ETIMEDOUT;
> >          } else {
> >             to_cnt = 0;
> >             i2c_recover_bus(dev);
> >             i2c_davinci_init(dev);
> >          }
> >       }
> >       if (allow_sleep)
> >          schedule_timeout(1);
> >    }
> > 
> >    return 0;
> > }
> > 
> > If there is a context switch immediately after the while statement,
> > the loop can return a timeout error while there is none. The
> > simple solution would be to check for bus busy again if the
> > timeout condition occurs. 
> 
> It seems the following patch suggests to your presumption, but 
> it is not the solution yet.

Yes, I don't think this bug is the root cause of this issue
either. Ben already tried a fix for this, but it has not
helped him as well.

Thanks,
Sekhar
