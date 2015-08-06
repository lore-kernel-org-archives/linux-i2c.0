From: Robert Abel <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: Re: [PATCH 5/6] i2c: Xilinx IIC: make reset after TX error configurable
Date: Thu, 6 Aug 2015 11:40:10 +0200
Message-ID: <CAMdRc4EhS_wDzLHoa4_vAh_A1wtsGy7gqt_sVLcC5-4LDV+b9A@mail.gmail.com>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1438344034-20211-7-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<55BEFD63.6090108@xilinx.com>
	<CAMdRc4F__S-dQOOsZv0pUtER5+-kwH=Mt+wfanvJXHWqS=YRMA@mail.gmail.com>
	<55C32666.6070304@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55C32666.6070304-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michal,

On Thu, Aug 6, 2015 at 11:18 AM, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>=
 wrote:
> Every patch like this has to fix something. If some certain IP versio=
ns
> are affected then it should be listed at least one version.

Please re-read my email. I said:
- I do NOT know of any bug.
- all information about a possible bug come from that three lines of
commentary which are in the _original_ mainline driver.
- there is no errata mentioned in any of the datasheets I read.

> Huh. Don't get what you are saying here. Based on your description it=
 is
> HW bug and it is completely fine to have dt property to avoid this bu=
g.
> Having another config property is just not acceptable solution now.

You misunderstood. To recapitulate:

- I have not seen this bug in action.-
- I have not observed this bug in simulation.
- I don't think it exists in current IP.
- I personally think any odd behavior the original committers might
have observed came down to bugs in their ISR.

If any errata had existed in previous IP, I would expect the
datasheets to mention this-- they don't. I have looked at datasheets
axi_iic_ds756 v1.01a, axi_iic_ds756 v1.01b, axi_iic_ds756 v1.02a and
xps_iic_ds606 v2.03a.
I have simulated axi_iic v1.02a and successfully use axi_iic v1.02a in
hardware with my patched driver without the CONFIG_I2C_XILINX_ERRATA
configuration option configured, i.e. # CONFIG_I2C_XILINX_ERRATA is
not set.

On the off-chance this bug _does_ exist in previous or current IP, I
provided this compile-time configurable option to enable the _old_
mainline behavior of resetting the IP after every TX error so as to
not break somebody's platform.
And that's why it isn't a DT property. It can always be promoted to a
DT property when the existence of any errata were actually verified,
but I have neither time nor inclination to do so.

Therefore, I _don't know_ which version of the IP _if any_ is
affected. If you require more information, I suggest you inquire with
Richard R=C3=B6jfors or possibly Ben Dooks about it. Richard R=C3=B6jfo=
rs is to
git blame for the reset-after-Tx-error functionality and the comment
mentioning a possible errata.

Regards,

Robert
