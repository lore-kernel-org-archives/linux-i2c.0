From: chris-jmrfutXsf6TiB9QmIjCX8w@public.gmane.org
Subject: Re: [PATCH 1/6] i2c pca954x: catch dereferencing from NULL-pointer
Date: Tue, 25 Aug 2009 13:00:47 +0200
Message-ID: <20090825130047.v0gzx5gxwk84804s@webmail.herzig.info>
References: <1251192966-25724-1-git-send-email-christian.herzig@keymile.com>
	<20090825100040.GF2039@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090825100040.GF2039-h5F9bMWSfx92wUeKyQHPq0EOCMrvLtNR@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> If pdata is NULL then the condition is false and the CPU should jump
> to the false branch and returning 0 or NULL. Did you really get error
> here?

Oh, I see! that patch becomes void! Thanks for your explanatory note.
