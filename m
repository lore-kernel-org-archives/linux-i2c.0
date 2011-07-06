From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Allow i2c_add_numbered_adapter() to assign a bus
 id.
Date: Wed, 6 Jul 2011 09:51:41 +0200
Message-ID: <20110706095141.0daca2db@endymion.delvare>
References: <20110627185505.19423.64214.stgit@ponder>
	<BANLkTi=6zxPUwGZ5JHhRGRHHaEgvNgiaHQ@mail.gmail.com>
	<20110705105330.63c113c8@endymion.delvare>
	<20110706063746.GA26611@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110706063746.GA26611-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Stephen Warren <SWarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 6 Jul 2011 00:37:46 -0600, Grant Likely wrote:
> Actually, now that I'm looking at things, I don't think there will be
> a conflict.  Go ahead and take it via your tree so that I don't make
> Linus' life harder than it needs to be.

OK, I've added the patch to my quilt series for the time being, so
it'll be in linux-next. Let me know if you change your mind before I
send it to Linus during the 3.1 merge window.

-- 
Jean Delvare
