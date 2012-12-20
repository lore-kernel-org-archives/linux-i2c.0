From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [lm-sensors] i2c tools build failure with gcc 4.6
Date: Thu, 20 Dec 2012 08:31:13 -0800
Message-ID: <20121220163113.GA5190@roeck-us.net>
References: <20121220010733.GA31336@roeck-us.net>
 <20121220104510.2fa8a0fb@endymion.delvare>
 <20121220142006.GB32230@roeck-us.net>
 <20121220153735.2ae73802@endymion.delvare>
 <20121220155354.3e600483@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121220155354.3e600483-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 20, 2012 at 03:53:54PM +0100, Jean Delvare wrote:
> On Thu, 20 Dec 2012 15:37:35 +0100, Jean Delvare wrote:
> > On Thu, 20 Dec 2012 06:20:06 -0800, Guenter Roeck wrote:
> > > On Thu, Dec 20, 2012 at 10:45:10AM +0100, Jean Delvare wrote:
> > > > Hi Guenter,
> > > > 
> > > > On Wed, 19 Dec 2012 17:07:33 -0800, Guenter Roeck wrote:
> > > > > Seen with latest i2c-tools from svn repository.
> > > > 
> > > > With the subversion repository having gone on vacation, "latest"
> > > > doesn't mean much :(
> > > > 
> > > Oh, right, "the latest one I have", which is svn revision 6075. Is that the
> > > latest ?
> > 
> > "svn status -u" says 6091 but I think this includes the changes to
> > other trees (lm-sensors.) I have i2c-tools/CHANGES at revision 6083.
> 
> The SVN repository should be back now, thanks to Axel Thimm.
> 
It is, thanks. No improvement, though; I still get the same error. Trying to
find out what is happening.

Guenter
