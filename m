From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 19:52:57 +0100
Message-ID: <87iqo5kg6u.fsf@macbook.be.48ers.dk>
References: <20090122150230.GA10952@enneenne.com>
	<20090123095110.7b0c7b82@hyperion.delvare>
	<878wp2ml52.fsf@macbook.be.48ers.dk>
	<20090123134833.GH12256@enneenne.com>
	<20090123172747.GB24751@tamay-dogan.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090123172747.GB24751-qCYv2r+mE47ltxMxsNcu6w@public.gmane.org> (Michelle Konzack's message of "Fri\, 23 Jan 2009 18\:27\:47 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michelle Konzack <linux4michelle-qCYv2r+mE47ltxMxsNcu6w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Michelle" == Michelle Konzack <linux4michelle-qCYv2r+mE47ltxMxsNcu6w@public.gmane.org> writes:

Hi,

 >> > I have been doing i2c multiplexers where the multiplexers themselves
 >> > are not controlled through i2c for years without problems.

 Michelle> So you use those Multiplexer only for level switching where
 Michelle> even on different ports the Address is unique?  This is
 Michelle> working with the Maxim chips too.

No, there can (and there are) multiple chips with the same
address. What I mean is simply that the mux is't controlled by writing
I2C commands to it, but through something else (in this case a
sram-like bus on a fpga).

-- 
Bye, Peter Korsgaard
