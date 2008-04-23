From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [i2c] platform_data when using of?
Date: Wed, 23 Apr 2008 20:20:50 +0200
Message-ID: <480F7E02.4020400@scram.de>
References: <20080423164523.GA4190@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080423164523.GA4190@pengutronix.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> Hello,
> 
> I finally could get the work started with I2C on a MPC8260-based
> platform. I applied Jochen's series on top of 2.6.25 and it seems I
> could get the i2c-cpm and the rtc-rs5c372 driver working (except that it
> doesn't autoload as a module, but I think this is my fault somewhere).
> I have not checked all yet, but at least some reasonable things do happen.
> 
> I now wanted to test the latest at24-driver on top of that and stumbled
> over the fact, that I can't directly add platform_data to the dts-file.
> (As at24 shall be a generic driver, data about the eeprom type needs to
> be provided.) If I understood of correctly, I need to create another
> child node and put all necessary data in there (what also means one
> cannot use the predefined macros for known chips in at24.h). After that
> I use of_get_property and collect the data.
> 
> So, at the end, every driver using platform_data has to cope with two
> mechanisms to get the desired data? This sounds questionable to me, but
> maybe I just got something wrong as this is my first contact with of.
> 
> Kind regards,
> 
>    Wolfram

You should probably send this question to the Powerpc list (added to cc)

Thanks,
Jochen
