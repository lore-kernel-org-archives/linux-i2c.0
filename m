Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC273DC4A0
	for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276025; cv=none; b=O2ZIBouBWM0k4H9C86Db9nJx1gYeg4Dzg8oGfGtK4OnJj4005Y8a8yOg/Vc4BXaPabt6mxXDCRYSr8UlQO3NPhRLcJ/kg4XRowxSstd7K2yKsp8Nv7st+XYxEWRRugfZxXB9W0e7Uhe79J4ePkhkjxN7rlQz2xUOjDr5vcflRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276025; c=relaxed/simple;
	bh=3uha1lyXdmQ7x72VDIiJdqg14BMev+suh2fIyXoFPqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFXON6O3N1AZYe/im7w8H/RMy9PcS+6sAIeb8peYzIJe+jLWbYmzGnIKChUuDMuW/MDm+szSvcun3fwvyztFQKnhmYex1G+DqWLSFHuEKZn9N+jcr6LdzE56fE1KV06rJL9pXM3KeBNX2h/ca5cHqCnbbmTXqZoZxZGlPkbqnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX9ezI7l; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX9ezI7l"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4728c12ba97so3616465f8f.0
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784276022; x=1784880822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L63z0ebNG5Tx2TMavcYbFNcfaVoRzFeosIrJj+Kz+x0=;
        b=UX9ezI7lTk0sSOZyzJn1oM7Qyc2ZPYgKxj/kUgSpRFZQ5VqChaZUiRtBrIwHct9Ub1
         wa648UhgIqwgHDKkHawyIvFBJdGryY5ke7Qi9PmpbUnpRF+haaddt5CVIR+S+PLm8xjk
         Vpb4RGKwq+8paqJxBoTjmJkQ4ho3hgy6ocVOtnHguyLFz78pIuSRVZaW3q0s5vElCwpV
         V+8w2Dx1LvzFCRvWIR3xDf3IGR3EKVjS8e18Yn1kAW2vsOG/COU5MVyz9FUDpnH0TFYr
         meALMaFZJ9YHgj156He5FtGUbKZ/UFu1j/D8FrxkLjgl0mZGSWPT6De5Q9VVzwcKDBaM
         I1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784276022; x=1784880822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L63z0ebNG5Tx2TMavcYbFNcfaVoRzFeosIrJj+Kz+x0=;
        b=VS1OZVI7ZPTWPB1SloptbPZtlaRsVNP0u5UYGevliFJjmTswez0q4mpY8vjdZGG2dR
         5A/7cItBnomZbCQWznkQbU0VLtoga688zxf+yKg/zLWw9/1Z0Sz3embhoF+/0VtCElUw
         UkSM5kyc5dmIratdQzJvGMdpy+yjZhzB1oAxzk64GoV9Hba5J5ZJ7H97tanans7BQjHi
         ALaN+Lu6qmb8p9o3S6TUDpBWjmsl9JPSfht5W8+ekQjRhujKDZqWlDiWweb4148+tMAM
         6mjL+JCeWrfWDCuztNgz5Z9CkBFWC+D+Nrpa/KzkeS+aHinFJMuC6OPRR5n3LbZ70kow
         M/JQ==
X-Forwarded-Encrypted: i=1; AHgh+RocetMfrIgEXdSK4vf5KwMVZLRs/4xUglYzRsOuCDSXZnhNRXuDhbsj2SFszoRoBg6baKeKxRl7M4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4gcisBSXrD+95XKiRq7ZN5JZPeYHhaoY3MmziqGtZilfGqqC
	VXplYwTHZbaNn7OZNIZbchm6AH1XuzmKlp2mNd7hNiEcIkU5FuNPnzGx
X-Gm-Gg: AfdE7clKXLMqVtPlAKT3+BD/L5qzWoXYQWqZxs3VJo30W8Iin7tjX7YDcR4QyTk8kiq
	vgsW52FJo6PYcOftQt2R52U2teJiSRpD4kVyquO0YdkjIZeWi/D+DEBzfFRY7Lh5YZBH4sLt3ea
	3LY/q/G2OUn2sxkjUmdoAZFdeqGBzVQ/GkcZKaWhUX8yDEprAqT6FrbsTpzaryb4w8O1qkpvwvn
	Y1UIrTUXkVt8/fuTjvGlAC23u+YqhJYOSRgQjoBnbtZ1SuZXs1C5CraOuLK4eycoBuuDs7/iKrk
	SpXQLAcqzdsGmHhgDNtaxT5hSPHgvU+O/JhSAZL/s4kUhlFFhBi5yH7wCjZO54aQ4FPwq8nb/Wt
	V0wJV5cPr5yCh5YmYUerK1W3Q5fg9fqYTz2dcvBB+bP7ydN87QglAAxTo+fyXw7QsO+EUBGD7oE
	bCzBRWrKpRnf3n5Plg
X-Received: by 2002:a05:600c:1d15:b0:495:43df:39c0 with SMTP id 5b1f17b1804b1-4954a513abfmr16350335e9.27.1784276021643;
        Fri, 17 Jul 2026 01:13:41 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96f19sm34988695e9.9.2026.07.17.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:13:41 -0700 (PDT)
Date: Fri, 17 Jul 2026 10:13:32 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org
Subject: Re: [RESEND PATCH 00/22] IIO: Clean out superfluous I2C checks for
 single transfers
Message-ID: <avufy4eyjrhdteaf57yzrygetgidy42z47uyhbdc6amsl6h42x@kcjz7oh2fnou>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
 <5e9b7479-ed16-48aa-bd4f-26abc09e690e@metafoo.de>
 <20260716162053.00006f99@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716162053.00006f99@oss.qualcomm.com>

On Thu, Jul 16, 2026 at 04:20:53PM -0700, Jonathan Cameron wrote:
> On Thu, 16 Jul 2026 07:55:32 -0700
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> > On 7/15/26 5:57 PM, Jonathan Cameron wrote:
> > > Resend to include linux-iio. Sorry to all who get it twice.
> > >
> > > This came up in a recent review and I realised I have been giving incorrect
> > > review feedback for years. Both i2_master_send() and i2c_master_recv() plus
> > > the dma safe variants only ever return either an error or the full buffer
> > > size.  Short accesses do not occur.  
> > There is actually one interesting corner case. If 
> > i2c_transfer_buffer_flags() returns 0 i2c_master_{send,recv}() will also 
> > return 0, in which case the updated drivers will now read uninitialized 
> > memory. Maybe i2c_master_{send,recv}() needs to be updated to translate 
> > that to -EIO.
> 
> That's indeed curious (and I'd missed it entirely!).
> 
> So ends up being either the master_xfer_atomic() or master_xfer() callbacks
> returning 0.  master_xfer_atomic() is novel, it's a union with xfer_atomic()
> and no one ever sets it via that union element but given the types are the same
> all calls will actually be to xfer_atomic().
> 
> Could remove that complexity whilst here but there a bunch of related callbacks
> (e.g. master_xfer() in union with xfer() where drivers are still using the old
> naming and I'm not sure I want to chase that through various subsystem trees
> right now (though for fun - and maybe profit) I had claude work out a series.
> Was fun watching it write a semantic patch and spend a while debugging it.
> Glad it has as much trouble with coccinelle scripts as the rest of us.
> There are still a few hundred instances and I haven't touched all the callbacks,
> just this pair.
> 
> Anyhow, back to the question of whether they do return 0.  Yup they do :(
> 
> https://elixir.bootlin.com/linux/v7.1.3/source/drivers/i2c/busses/i2c-cadence.c#L1153
> 
> So any defense against that case would require hardening further up the stack.
> 
> +CC Andi and the i2c list.  Would anyone mind a patch to do something like:
> 
>  static inline int i2c_master_recv(const struct i2c_client *client,
>                                   char *buf, int count)
>  {
> -       return i2c_transfer_buffer_flags(client, buf, count, I2C_M_RD);
> +       int ret;
> +
> +       ret = i2c_transfer_buffer_flags(client, buf, count, I2C_M_RD);
> +       if (ret == 0)
> +               return -EIO;
> +
> +       return ret;
>  };
> 

I do think something like the above makes sense. It goes in accordance
with the expectations given by the docs.

- Nuno Sá

