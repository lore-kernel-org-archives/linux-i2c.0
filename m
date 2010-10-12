From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: skip address detection if provided in board_info
Date: Tue, 12 Oct 2010 11:01:40 -0700
Message-ID: <20101012110140.00003391@unknown>
References: <1286838635-16474-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20101012092822.6f4e4aa5@endymion.delvare>
	<20101012162140.429b03b3@feng-i7>
	<20101012104707.3318511d@endymion.delvare>
	<20101012173028.638cd3ae@po-laptop>
	<20101012133425.490e3c4c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101012133425.490e3c4c-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, i2c list <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, al-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


>
>> So I still prefer the option of adding a flag, and leave the choice for
>> platform code whether to do the detect. If you agree, I would make a
>> cleaner patch.
>
>And I prefer that you set the class flag value in the platform data and
>have your i2c adapter driver read it. This is already supported and
>should work very fine without any change to i2c-core. I see no point in
>adding a global flag when we already have a much finer-grained setting
>available.
I agree that assigning the class code to adapter will solve our problem
but I do have a question/concern.

What if you have mixed devices under one adapter with some prefer to
have detect funtion some not. Then all detect functions will be ignored
if i2c adpater class code is 0. The granularity of information provided by
our FW is per i2c device.

Seems we have three cases:
1. adaptor class = 0, no detect
2. adaptor class !=0, FW provide address via board info, no detect
3. adaptor class !=0, no FW board info, do detect by default, but should
allow platform code override

I would think we need a global flag for case #3.

Thanks,

Jacob
