Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3472EF64F;
	Tue,  3 Feb 2026 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112397; cv=none; b=Dq2r3wjYouMWGmawNKbcjSDjdJBcClayv0fqohQqFsW12RstKtrUrWhbhvR78RJnBxRYQBoZGfqCLhhSMouWJrIfyGhK/4kkJFLpVTuw2wPyf43ljjCT5QPWvkCeLjbo+I58EgzCyIPvrv/nKkjW9vCQFKXgHVoFT5PFQpQtqcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112397; c=relaxed/simple;
	bh=eLCHDZQSBnp8TQNvGvK8JfVIMSYc96hG4trl4sdtfqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2cMCoiT42JGL0BKa7BW3sjAKWCilo2N5v4XKbiJ+i6MEgie7SAwhVaanazmwdEtkJlly01WOj1yhrK/IbXdw6cQ6tPpuzCG1NGUF2+30gRQmVfHiA+F2cXrVt84qyXvN2dp9XoA6xQRIiWs2CIvCrnGTPLLRElhyDItPBDb9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ta07Qlpl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ta07Qlpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770112396; x=1801648396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eLCHDZQSBnp8TQNvGvK8JfVIMSYc96hG4trl4sdtfqk=;
  b=Ta07Qlpl2w6DWhwcbABwEhSxU/AK1jvSujtLRTPIrokVNFG9ztRVExEK
   BPdwrZHAiXg0tDjvu9+1jrupoKkPlviGUxO/xc2rIoIYyACupr0yaPnId
   RedDVfoE9LyX244PPYG+bCXF4uyh8SefWagVbGOo7VhQ7mYDXQG2zMxlO
   0x1vlps1IYdFD/+3iSs+3KVRCKdYlCHl0mwEpgyO/JGdzbuQLDlCTW5SR
   lSGAAa/1Er20dfdvJjvC9fYYdC2yE9gx4DAFnCPQViuZhzh5l2uo1B4oG
   KdadzHUjdUnoXOxWcK0dp5ZPyGlJEdhHgxDS8kZT3OcbtXPcbC9MvO6lZ
   A==;
X-CSE-ConnectionGUID: 0elgfAwISBa/kN7pbNHEkQ==
X-CSE-MsgGUID: a1VlzXh2QcqDFa8k0S0IYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="81908316"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="81908316"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:53:16 -0800
X-CSE-ConnectionGUID: GNFGkw07RIOTfgCtUURYtw==
X-CSE-MsgGUID: JzwdxFYWSxW57x3BwOns+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209955718"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:53:12 -0800
Date: Tue, 3 Feb 2026 11:53:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C
 controller
Message-ID: <aYHFhsjUo1SzAlQF@smile.fi.intel.com>
References: <cover.1769476820.git.zhoubinbin@loongson.cn>
 <402121da829497fc97f1461c8aaa3a44252c3f06.1769476820.git.zhoubinbin@loongson.cn>
 <aXh000kBfaqd1G9H@smile.fi.intel.com>
 <CAMpQs4JTqWr6AqRwEO9bcno-_MjjE8GKm_kUvrpy7m_tLMtuSQ@mail.gmail.com>
 <aXtw9h8WUs5H9MgC@smile.fi.intel.com>
 <CAMpQs4+Rk7-ERUetW_V4ojGxLtpzoX+hGgr7wV+0iQ8Uhdri4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4+Rk7-ERUetW_V4ojGxLtpzoX+hGgr7wV+0iQ8Uhdri4A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 02:39:28PM +0800, Binbin Zhou wrote:
> On Thu, Jan 29, 2026 at 10:38 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Jan 29, 2026 at 04:07:06PM +0800, Binbin Zhou wrote:
> > > On Tue, Jan 27, 2026 at 4:18 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Tue, Jan 27, 2026 at 10:47:57AM +0800, Binbin Zhou wrote:

...

> > > After run `pahole`, the structs are reorganized as follow:
> > >
> > > pahole --show_reorg_steps --reorganize --sort -C loongson2_i2c_priv
> > > i2c-ls2x-v2.o
> > > struct loongson2_i2c_priv {
> > >         struct i2c_adapter         adapter
> > > __attribute__((__aligned__(8))); /*     0  1064 */
> > >         /* --- cacheline 16 boundary (1024 bytes) was 40 bytes ago ---
> > > */
> > >         struct clk *               clk;                  /*  1064
> > > 8 */
> > >         struct completion          complete;             /*  1072
> > > 32 */
> > >         /* --- cacheline 17 boundary (1088 bytes) was 16 bytes ago ---
> > > */
> > >         struct regmap *            regmap;               /*  1104
> >
> > It's better to keep pointers like clk and regmap next to each other.
> > They are semantically coupled as "resources".
> >
> > > 8 */
> > >         int                        speed;                /*  1112
> > > 4 */
> > >         int                        parent_rate;          /*  1116
> > > 4 */
> > >         struct loongson2_i2c_msg   msg;                  /*  1120
> > > 24 */
> > >
> > >         /* XXX last struct has 4 bytes of padding */
> > >
> > >         /* size: 1144, cachelines: 18, members: 7 */
> > >         /* paddings: 1, sum paddings: 4 */
> > >         /* forced alignments: 1 */
> > >         /* last cacheline: 56 bytes */
> > > } __attribute__((__aligned__(8)));
> >
> > ...
> >
> > > pahole --show_reorg_steps --reorganize --sort -C loongson2_i2c_msg
> > > i2c-ls2x-v2.o
> > > struct loongson2_i2c_msg {
> > >         u8                         addr;                 /*     0
> > > 1 */
> > >         bool                       stop;                 /*     1
> > > 1 */
> > >
> > >         /* XXX 2 bytes hole, try to pack */
> >
> > >         u32                        count;                /*     4
> > > 4 */
> > >         u8 *                       buf;                  /*     8
> > > 8 */
> >
> > Also think about it (don't blindly follow the `pahole` automatic mode).
> > This is much better if you move the pointer to be the first, followed
> > by a count, result, and others.
> >
> > >         int                        result;               /*    16
> > > 4 */
> > >
> > >         /* size: 24, cachelines: 1, members: 5 */
> > >         /* sum members: 18, holes: 1, sum holes: 2 */
> > >         /* padding: 4 */
> > >         /* last cacheline: 24 bytes */
> > > };
> >
> > TL;DR: don't use `pahole` blindly. Use the common sense.
> 
> Sorry, I slacked off.
> How about the organized data structure as follows:
> 
> struct loongson2_i2c_msg {
>         u8      *buf;
>         u32     count;
>         int     result;
>         u8      addr;
>         bool    stop;
> };
> 
> struct loongson2_i2c_priv {
>         struct i2c_adapter              adapter;
>         struct completion               complete;
>         struct clk                      *clk;
>         struct regmap                   *regmap;
>         int                             speed;
>         int                             parent_rate;
>         struct loongson2_i2c_msg        msg;
> };

At the first glance looks okay to me.

-- 
With Best Regards,
Andy Shevchenko


