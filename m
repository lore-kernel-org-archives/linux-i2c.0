Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB3019D093;
	Tue, 24 Mar 2026 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322882; cv=none; b=g4gYyXh7ObwySg4SsH4VOoaCmb4vkuTCdEmDHPmRkzKkVJLwmOH0DldibMPG1F6wC0OP+adnnzmcXtGyTva1UsIj1CIpkSbYT0PL9mqqq+aVjxSikGVhW3R3XYjglLBwlDhC3wnuMntMpELDA5d3Q7GkimN/Ys2mTgEmw1NsUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322882; c=relaxed/simple;
	bh=5zpPfK9qx4nsVjwcncSCblXIhDwd/QWTTgqCxW1t81k=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=s7dHpZa0eS3EI0dosBNuuI8jSSs1OsSJuyjkDayQZv6IeDMj8rbEBd5xI7OYvRRQNH9y6d3pm1VTOcuKhMuzLF/8p0CoMhhLXNEc27SH/wg7MwZrskjJsZ31lcP5FgFyGhSxRcB7TUdQjhjjY3Ai+4TvWuagnt0/NHnc5eORbL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8Dx_6u8BMJptBAeAA--.27076S3;
	Tue, 24 Mar 2026 11:27:56 +0800 (CST)
Received: from [10.20.42.101] (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJDxTMK7BMJpS+hbAA--.42028S3;
	Tue, 24 Mar 2026 11:27:55 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Subject: Subject: Re:Re: [PATCH v1] LoongArch: add i2c clocks and clock-div
 parameter parsing.
Message-ID: <6a88588c-5ec3-84b8-6bd7-be107e36e529@loongson.cn>
Date: Tue, 24 Mar 2026 11:27:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxTMK7BMJpS+hbAA--.42028S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr4DGrWrXF18XFW7CrWDJrc_yoW5tF1DpF
	ykGFWDCryUJF1kXr4DJryUXFy5Jws8JayUGr18JFyDXF43Jr1qqF1UXr1q9r18JF48G34U
	Xa1DJr1UuF17ZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PU
	UUUU=

Hi,  Binbin:


Sorry,  due to email reason,  I did not see your reply in a timely.

For your suggestion, I will make the changes as soon as possible.


Thanks,

Hongliang Wang


From: Binbin Zhou <zhoubb.aaron@gmail.com>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
     Andi Shyti <andi.shyti@kernel.org>,
      linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
      loongarch@lists.linux.dev
Subject: Re: [PATCH v1] LoongArch: add i2c clocks and clock-div 
parameter parsing.
Date: Wed, 11 Feb 2026 12:23:45 +0800    [thread overview]
Message-ID: 
<CAMpQs4LeFNEXyg-fVDiSDpEVdbPAY5Z5gL7-5s5uZ52BWmXP5w@mail.gmail.com> (raw)
In-Reply-To: <20260211025057.29746-1-wanghongliang@loongson.cn>

Hi Hongliang:


Bad commit subject, it should start with:
i2c: ls2x:

On Wed, Feb 11, 2026 at 10:51 AM Hongliang Wang
<wanghongliang@loongson.cn> wrote:
 >
 > On 3A/7A/2K platform, i2c ref clocks and clock divisor maybe
 > different, through firmware parameter passing, "clocks" and
 > "clock-div" are used to describe i2c ref clocks and divisor.

I feel it's necessary to specify which platforms are different in the
commit message.
 >
 > Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
 > ---
 >  drivers/i2c/busses/i2c-ls2x.c | 8 +++++++-
 >  1 file changed, 7 insertions(+), 1 deletion(-)
 >
 > diff --git a/drivers/i2c/busses/i2c-ls2x.c 
b/drivers/i2c/busses/i2c-ls2x.c
 > index b475dd27b7af..562bf32a9d6c 100644
 > --- a/drivers/i2c/busses/i2c-ls2x.c
 > +++ b/drivers/i2c/busses/i2c-ls2x.c
 > @@ -96,6 +96,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void 
*dev_id)
 >  static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
 >  {
 >         u16 val;
 > +       u32 pclk;
 > +       u32 div;

Place them in a single line.
 >         struct i2c_timings *t = &priv->i2c_t;
 >         struct device *dev = priv->adapter.dev.parent;
 >         u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
 > @@ -107,12 +109,16 @@ static void ls2x_i2c_adjust_bus_speed(struct 
ls2x_i2c_priv *priv)
 >         else
 >                 t->bus_freq_hz = LS2X_I2C_FREQ_STD;
 >
 > +       if (!device_property_read_u32(dev, "clocks", &pclk) &&
 > +               !device_property_read_u32(dev, "clock-div", &div) && 
div != 0)
 > +               val = (pclk * 10) / (div * t->bus_freq_hz) - 1;

I think you should update dt-binding synchronously and verify whether
the existing i2c node in DTS{i} requires updating.
 > +       else
 > +               val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
 >         /*
 >          * According to the chip manual, we can only access the 
registers as bytes,
 >          * otherwise the high bits will be truncated.
 >          * So set the I2C frequency with a sequential writeb() 
instead of writew().
 >          */
 > -       val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
 >         writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + 
I2C_LS2X_PRER_LO);
 >         writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + 
I2C_LS2X_PRER_HI);
 >  }
 > --
 > 2.47.2
 >
 >

-- 
Thanks.
Binbin

