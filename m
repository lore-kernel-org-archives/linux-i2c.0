From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/1] Blackfin I2C Driver: Functional
	power	management support
Date: Mon, 28 Jul 2008 14:18:36 +0100
Message-ID: <20080728131836.GC2716@fluff.org.uk>
References: <1217140914-21718-1-git-send-email-cooloney@kernel.org>
	<20080728092317.GB2716@fluff.org.uk>
	<386072610807280307k7bed8922t396be43b28fa749a@mail.gmail.com>
	<20080728110845.GX26938@trinity.fluff.org>
	<8A42379416420646B9BFAC9682273B6D035F0772@limkexm3.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8A42379416420646B9BFAC9682273B6D035F0772-pcKY8lWzTjquVPpjEGsWsTcYPEmu4y7e@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 28, 2008 at 01:16:44PM +0100, Hennerich, Michael wrote:
> 

> >> > if removing the SSYNC() call is ok, then I'll queue this into
> >> > my tree which I will be requesting a pull asap.
> >
> >ok, this is in my queue, unless anyone objects then it'll be pushed
> >out later today.
> 
> Removing this SSYNC is absolutely safe. There are potentially many other
> ones that can be removed too.

Ok, next time a note to this effect in the description
would be useful to inform everyone that you've not just
accidentally removed something the driver might rely on
having.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
