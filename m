From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: i2c-ocores timeout bug
Date: Thu, 30 Jun 2011 09:10:46 +0200
Message-ID: <871uyb4ww9.fsf@macbook.be.48ers.dk>
References: <BANLkTikEESnV9+hc=VFg=qFGOXeg4o0sOQ@mail.gmail.com>
	<BANLkTino1RYuDDjcXZYdJ1LyeSHz6h=ACw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTino1RYuDDjcXZYdJ1LyeSHz6h=ACw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org> (Andrew
	Worsley's message of "Thu, 30 Jun 2011 08:55:42 +1000")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Worsley <amworsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Andrew" == Andrew Worsley <amworsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

 Andrew> So far no response on this bug I reported about 2 weeks ago that
 Andrew> includes a proposed fix.

 Andrew> Could some one consider adding in the fix into the relevant tree?

Sorry, things got somewhat delayed because:

- You didn't email me (the maintainer)
- I've been caught up with real life stuff (my daughter has been ill)

I'll take a look at your patch in detail later today.

 Andrew> On 15 June 2011 08:33, Andrew Worsley <amworsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
 >> Hi, I have hit upon a bug in this driver in the 2.6.32 which caused
 >> memory corrupt and crash in my kernel. It appears to be still present
 >> in 3.0-rc3

 Andrew> http://thread.gmane.org/gmane.linux.drivers.i2c/8543

 Andrew> I have since identified the cause of the problem was the wrong clock
 Andrew> frequency for the FPGA. I mis-understood the clock frequency to
 Andrew> be the i2c bus frequency - but it is actually an FPGA clock frequency.
 Andrew> Perhaps others will make the same mistake as well.

Ahh yes, I did find your timeout issues odd. It is indeed the input
clock to the ocores IP block, like it's documented in the i2c-ocores
vhdl spec.

In the years i2c-ocores has been in the tree, this is the first time I
ever heard about anyone making that mistake though. The documentation of
the platform data also says:

        u32 clock_khz; /* input clock in kHz */

 Andrew> In fact as it stands there is no module parameter to change your i2c
 Andrew> bus frequency - other than by fiddling your FPGA clock frequency.
 Andrew> Better would be a separate parameters for each with a clearer names.

Yes, currently the i2c speed is always the standard 100KHz. I'm not
opposed to a patch adding a i2c_clock_khz member to
ocores_i2c_platform_data as long as it doesn't break existing boards
(E.G. 0 should get handled as 100Khz).

-- 
Bye, Peter Korsgaard
