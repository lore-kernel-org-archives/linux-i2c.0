From: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c:at91: Add device tree property to set clock-frequency
Date: Mon, 24 Feb 2014 09:06:02 -0500
Message-ID: <CAJjB1qKydFdDpoNR9XH9bGz2jdxcAizfQ5NcV5P1mbUsyoXOGQ@mail.gmail.com>
References: <1393143540-627-1-git-send-email-mark.roszko@gmail.com> <20140224104435.GB5087@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140224104435.GB5087@ldesroches-Latitude-E6320>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Sorry, actually now that I look at the generated patch, it shouldn't
have compiled when I was testing... I accidently referenced "ret" for
the return value but that's not supposed to be defined anywhere.
Resubmitting the patch without that oversight in after I reload my
build tree. "ret" just needs to be changed to "rc" which is defined in
that function.
