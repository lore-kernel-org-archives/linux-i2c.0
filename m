From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: Add restart support to i2c-pnx
Date: Sat, 5 Feb 2011 16:07:01 +0000
Message-ID: <20110205160701.GC15795@trinity.fluff.org>
References: <acc33abdeea1fb1dd33f6919e7a4c4e4@imap.raing.si> <AANLkTimrs02v70OMkExsfBKhdOU1pxoFoAEn780qj_v-@mail.gmail.com> <aeed818a0cfb7836e7599aad4ffb9874@imap.raing.si> <20110202134102.1fd5b68d@endymion.delvare> <cd08bef3d940dd8ede1abc5bee93b190@imap.raing.si> <083DF309106F364B939360100EC290F80B0E17D10F@eu1rdcrdc1wx030.exi.nxp.com> <1296681822.15861.3.camel@orion> <20110202222404.GW15795@trinity.fluff.org> <f72f4b6ef01079e2ecd41b39041b4082@imap.raing.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f72f4b6ef01079e2ecd41b39041b4082-Z5eBVJDltO98b/lofMYZ3A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: matej.kupljen-nWYkTt+LGLL1KXRcyAk9cg@public.gmane.org
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 03, 2011 at 08:54:30AM +0100, matej.kupljen-nWYkTt+LGLL1KXRcyAk9cg@public.gmane.org wrote:
> Ben,
> 
> >> -	struct i2c_pnx_algo_data *alg_data)
> >> +	struct i2c_pnx_algo_data *alg_data, int repeated)
> > 
> > bool repeated.
> 
> I don't agree.
> Since this is C and C++, we do not have a bool keyword.
> And, there is no variable declared as bool in the source file this 
> is why and defined this as int and not as bool.

the kernel has this.
 
> >> +	if ((!repeated) && (wait_timeout(I2C_PNX_TIMEOUT, alg_data))) {
> > 
> > no need for () around !repeated.
> 
> Agreed, but for the clarity sake.

Makes it less clear, there's more on each line.
 
> >> +		if((i > 0) && !(pmsg->flags & I2C_M_NOSTART))
> > 
> > no need for () around i > 0
> 
> Same as above. I my opinion it is better to use more parentheses then
> fewer, since you do not rely on compiler implementation.
> 
> Regards,
> Matej
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
