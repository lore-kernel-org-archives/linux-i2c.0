Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313673644A1;
	Mon, 23 Feb 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846688; cv=none; b=j9zjFz+K8ceAERb9ixXHWywgj79bhTUUXn59TvSsspES4X4t6OYbslgl1VufOkNXoev5BjpD9bm/agoLOqJSNnOz72cYTaB/YgbB7DGuLLrLk6CGIlh3TreoFojpQDcO0YuhVnlhYSU5pTZe+X2D6ibF3m8woEtgH0w6o/Y7SVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846688; c=relaxed/simple;
	bh=RS1OiitkwGJejhOeFmPnjt/SklMgdmXO4qDV8CO4Zbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOscUW7Wm1QE2J8VHM5JAw9GkxqzE5sHUgxIsHs0VL85Bpw8CJk1yLKSDty2vV0LWDkMNl2gqApWVON11Tfq7aTrN/5GSUZIDSP+kog4Lfl0R7Q6xFQBhb7MSXqwYIfhdY4Kp3B7UWJYP5G/abjKb91xLCOwCQ6FMObhHisSo6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9+rWyBm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9+rWyBm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771846688; x=1803382688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RS1OiitkwGJejhOeFmPnjt/SklMgdmXO4qDV8CO4Zbw=;
  b=M9+rWyBm3lLPYv7G+77fvsb7Wsqh8Atgxgu/5a5nGIYLHkb8aLmKovu+
   9kNKTz6LvV5bvAm0LudHXZxo9EGL2lqex7yLTpEjdsTYWUsq7e0M2qQIJ
   uaEkY+x1ZlexpjEt5V8QuCsr1mkzGgvwZ7B5LqJ/BsCr2VVEvGUfjzTBV
   wOerIQhtQQ8/qWVdY1XglqMOEdfC43xyCgmd9R5JSnXC7c/MqXkZSvVrd
   lR7JTmkqF0WvhQU3wxd3OmVNJ2iloJvZRMU++guAZ6oZrBK0i+GQW/GZD
   XfeKPndX3luP+kERK1KdjFpR48j0EKgo/Q+6th/q7kZlAUogFwMnhvaEd
   w==;
X-CSE-ConnectionGUID: 5PmY34lQScu4Ms89dUX1tQ==
X-CSE-MsgGUID: NSy8zl+ERISGiYzPYVFAmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72816531"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72816531"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:38:06 -0800
X-CSE-ConnectionGUID: h/fmYwXMRzKQ8Zc/ft5m1Q==
X-CSE-MsgGUID: g6esFwSMRDCU15w43mcMLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="220533941"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:38:02 -0800
Date: Mon, 23 Feb 2026 13:37:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Hans Hu <hanshu@zhaoxin.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] i2c: mv64xxx: use i2c_adapter_dev()
Message-ID: <aZw8F3tQtH3ZytzN@smile.fi.intel.com>
References: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
 <20260223-i2c-adapter-dev-wrapper-v2-4-d02946569773@oss.qualcomm.com>
 <aZwaV8LdexyU5jil@smile.fi.intel.com>
 <CAMRc=Mfebg2+o_wUGQaSv+yUNgYJgcJMA_Z4_K0NKEi-cvfWvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfebg2+o_wUGQaSv+yUNgYJgcJMA_Z4_K0NKEi-cvfWvA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 10:23:40AM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 23, 2026 at 10:14 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 23, 2026 at 10:02:52AM +0100, Bartosz Golaszewski wrote:

...

> > > mv64xxx_i2c_xfer_core(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >
> > >       struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
> > >       int rc, ret = num;
> > >
> > > -     rc = pm_runtime_resume_and_get(&adap->dev);
> > > +     rc = pm_runtime_resume_and_get(i2c_adapter_dev(adap));
> > >       if (rc)
> > >               return rc;

...

> > >       drv_data->num_msgs = 0;
> > >       drv_data->msgs = NULL;
> > >
> > > -     pm_runtime_put_autosuspend(&adap->dev);
> > > +     pm_runtime_put_autosuspend(i2c_adapter_dev(adap));
> > >
> > >       return ret;
> >
> > These two changes are in the same function, perhaps temporary variable
> > would be better?
> 
> If all else is fine, maybe let's do it in a follow-up?

I gave already a tag, this is just a nit-pick / side note, it doesn't need
to be addressed on its own.

-- 
With Best Regards,
Andy Shevchenko


