From: David Goodenough <david.goodenough-hd8OpYRHSlec/75gGNOK3g@public.gmane.org>
Subject: Re: V2 API
Date: Fri, 30 Sep 2011 12:28:06 +0100
Message-ID: <201109301228.07248.david.goodenough@linkchoose.co.uk>
References: <201109281559.45060.david.goodenough@linkchoose.co.uk> <201109301134.38697.david.goodenough@linkchoose.co.uk> <20110930130645.5ff8576b@endymion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110930130645.5ff8576b-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 30 Sep 2011, Jean Delvare wrote:
> On Fri, 30 Sep 2011 11:34:38 +0100, David Goodenough wrote:
> > On Wednesday 28 Sep 2011, David Goodenough wrote:
> > > Doing a Google search looking to see if there was userland support
> > > for SMBALERT messages I saw references to the V2 API which last year
> > > was "being developed".  Did this happen, and is it defined anywhere?
> > 
> > I take it from the fact that no-one has replied, that the V2 API is
> > not being worked on or has stalled.
> 
> I take it from the fact that no-one has replied, that "V2 API" is an
> awfully vague subject line, so odds are that nobody read your post in
> the first place. Try to come up with a better subject line next time.
It was the only name I found for any effort to address this problem.
And that was from a message which I think was on this mailing list about
a year ago.
> 
> > Is there any way using the
> > existing API for userland code to be notified of an incomming
> > SMBALERT?
> 
> Not that I know of, and I wasn't even aware that efforts had ever been
> ongoing to achieve this.
So I take it that the only way to do this would be to write a kernel
driver?

David
