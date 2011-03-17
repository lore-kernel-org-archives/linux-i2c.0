From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: How to put extra clock cycles on i2c cavinci, problems on
	omapl138 (logic pd som)
Date: Thu, 17 Mar 2011 19:58:57 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C30830A@dbde02.ent.ti.com>
References: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3@sewerin.de>
	<AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs@mail.gmail.com>
	<OFCCCD2C6E.D899BA32-ONC1257856.00307955-C1257856.00323B2B@sewerin.de>
	<AANLkTinAgDKe8GD5GQoKaJ3p2s1Pj_DWduEnp6deZu=f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <AANLkTinAgDKe8GD5GQoKaJ3p2s1Pj_DWduEnp6deZu=f@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>, "Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org" <Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org" <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 17, 2011 at 18:55:00, Ben Gardiner wrote:

> I noticed on the e2e forums that there is a reason why the PSP uses a
> bitbanging i2c interface -- since the 1.0v OPP makes the i2c
> controller unusable [1] (I've added Sekhar to the CC since he pointed
> out the problem in that post).

There was a problem with the way I2C was implemented on the SoM. Here is
the information I have for the modifications required on the SoM.

"
It is likely that the errors seen were a result of the buffer on the I2C clock.  The hardware fix for this issue is to remove U24 and R161 and short U24 pins 2 to 4.
"

There should be an EVM with these fixes already, though I have not
tested it myself.

Also, recently a bug in the I2C driver was brought to my attention.
In the bus busy function:

/*
 * Waiting for bus not busy
 */
static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
					 char allow_sleep)
{
	unsigned long timeout;
	static u16 to_cnt;

	timeout = jiffies + dev->adapter.timeout;
	while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
	       & DAVINCI_I2C_STR_BB) {
		if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
			if (time_after(jiffies, timeout)) {
				dev_warn(dev->dev,
				"timeout waiting for bus ready\n");
				to_cnt++;
				return -ETIMEDOUT;
			} else {
				to_cnt = 0;
				i2c_recover_bus(dev);
				i2c_davinci_init(dev);
			}
		}
		if (allow_sleep)
			schedule_timeout(1);
	}

	return 0;
}

If there is a context switch immediately after the while statement,
the loop can return a timeout error while there is none. The
simple solution would be to check for bus busy again if the
timeout condition occurs. There should be a more elegant way
to write the loop, but it is too late in the evening to think
about it :)

I doubt if this is related to the errors you guys are seeing,
but it is worth trying anyway.

Thanks,
Sekhar
