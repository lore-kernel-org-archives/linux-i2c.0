From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 3/3] Add device tree compatible aliases to
	i2c	drivers
Date: Thu, 24 Jan 2008 18:33:17 -0600
Message-ID: <47992E4D.7010500@freescale.com>
References: <20080123020912.31675.48787.stgit@terra.home>	<20080123020916.31675.98481.stgit@terra.home>
	<20080125003249.GA30794@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080125003249.GA30794-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Olof Johansson wrote:
> For example, for an eeprom I might have: "MCHP,24lc128est",
> "MCHP,24xx128", "24c128". The at24 driver (not in mainline yet :) would
> likely match with "24c128", and it would normally not make sense to have
> to list all specific vendors and models of the device type in question
> in the driver.

It's not really about the vendors of the device, but the namespace it 
goes into.  If there's really no canonical vendor name, then a plain old 
"24c148" might make sense, but that seems like it'd be fairly rare.

> I can't register a board_info for each of the compatible fields without
> changing the way the i2c drivers are registered, since the creation of
> the duplicate entries will start reporting errors.

Even with the current i2c changes that have been flying around the 
lists?  If so, it should be fixed...

> So it seems that the solution would be to make i2c_board_info take a
> list of names for the device, and each of them has to be matched with
> all drivers, taking the first match.

Agreed.

-Scott


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
