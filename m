From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c_smbus_write_block_data does not send all bytes?!
Date: Tue, 15 Jul 2008 15:13:21 +0200
Message-ID: <20080715151321.266cf505@hyperion.delvare>
References: <20080715143258.2bef9c1e@hyperion.delvare>
	<732644.12112.qm@web27604.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <732644.12112.qm-qWTMlLQujKzGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: xpage_de-LWAfsSFWpa4@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 15 Jul 2008 13:02:31 +0000 (GMT), Nick Teen wrote:
> --- Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > If that's all the details you can provide, then you're on your own,
> > sorry. I won't spend the whole day extracting every bit of information
> > from you.
> 
> Sorry for disturbing the peace...  my setup is very simple and I
> cannot gauge whats important and what is unimportant. My idea was
> to send an I2C command to the frontpanel pic to switch on an LED.
> I've captured the traffic (of the orig. OS) and trying to send
> these commands again under linux. But you see: without success.
> 
> Thanks for your endeavours! I dont want to steal your time.

My point is that if you want more help, you have to provide
information. Nobody here can guess what your setup is, especially when
you are apparently doing something unusual.

For example: what is an "iptv box"? You shouldn't assume that everybody
know what it is. I have no clue!

What we need, amongst other things, is a clear view of what your
physical environment is. You apparently have a PIC connected on some
I2C bus, but you never clearly said what I2C bus it was! I suspect a
bus driver bug, but at this point I simply have no idea which driver
that would be. You mentioned the i2c-i801 driver, but I would be very
surprised to see a PIC connected on that bus, unless you soldered it
yourself.

So, please don't only answer my questions: anticipate them. Tell us
everything that might be useful. And don't fear to give us too much
information - it's way better than not enough information, and we can
filter out anything that we don't think is relevant.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
