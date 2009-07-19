From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c/tsl2550: Use combined SMBus transactions
Date: Sun, 19 Jul 2009 11:52:20 +0200
Message-ID: <20090719095220.GJ5323@enneenne.com>
References: <20090715222824.2250d26b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090715222824.2250d26b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michele De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 15, 2009 at 10:28:24PM +0200, Jean Delvare wrote:
> Make the I/O faster, mainly by using combined SMBus transactions when
> possible. While the TSL2550 datasheet doesn't say the device supports
> them, they seem to work just fine in practice, and a combined
> transaction is faster than two simple transactions in many cases and
> always more reliable.
> 
> A side effect is to suppress the delays between SMBus writes and
> reads. The datasheet doesn't say they are needed and things work just
> fine for me without them.
> 
> I also couldn't see any reason for the delay between reading the two
> channels. Nor for the loop to get a reading in the first place. The
> 400 ms delay between samples only matters at chip power-up, after that
> the chip always hold the previously sampled value so we never get to
> wait.
> 
> All these changes make reading the lux value much faster and cheaper.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Michele De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
> Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> ---
> Michele, Rodolfo, can you please test and confirm the driver still
> works OK for you? Thanks.

I'm sorry but I cannot do it right now (and in the near future) since
my hardware is out of duty, but if Michele and you have tested this
new implementation then the modification it's ok for me! :)

Acked-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
