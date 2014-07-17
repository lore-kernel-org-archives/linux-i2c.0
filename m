From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Fix the alignment of the device table
Date: Thu, 17 Jul 2014 08:29:30 +0200
Message-ID: <20140717082930.0dcad551@endymion.delvare>
References: <20140623103658.57df2c14@endymion.delvare>
	<20140716172309.GD2759@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140716172309.GD2759@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, 16 Jul 2014 19:23:09 +0200, Wolfram Sang wrote:
> On Mon, Jun 23, 2014 at 10:36:58AM +0200, Jean Delvare wrote:
> > A long name broke the alignment, shift the columns a bit to fix it and
> > make the table look nice again. While we're here, switch to the
> > standard comment style to make checkpatch happy.
> > 
> > Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> > Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> 
> Hmmm, what about giving the names even more space so we have some buffer for the
> future? And what about replacing spaces with tabs?

I considered it, but could not make up my mind.

The table already spans to column 74. This does not leave that much
room for growing (table) columns. I am not sure if we would rather use
the remaining space to have some margin for the name column, as you
suggest, or keep it as spare space for an extra column if future
chipsets ever implement a new feature.

Currently, columns are aligned on 3, 27, 36, 44, 52, 60 and 68. None of
these values are multiple of 8, so the use of tabs would not help much,
unless we shift everything first.

One possibility is to switch to tabs and shift all columns (but the
first) by 4 to the right. This rules out the addition of a column in
the future, but otherwise fulfills your desire.

To be honest, I don't really care. All I wanted is that columns are
properly aligned. If the plan above makes you happier then fine with
me, I'll do that.

-- 
Jean Delvare
SUSE L3 Support
