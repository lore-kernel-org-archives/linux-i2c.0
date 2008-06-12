From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch/rfc 2.6.26-rc5] i2c: schedule legacy gpio driver
	removal
Date: Thu, 12 Jun 2008 13:55:23 -0700
Message-ID: <200806121355.23222.david-b@pacbell.net>
References: <200806111317.21060.david-b@pacbell.net>
	<20080612125729.136d642b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080612125729.136d642b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 12 June 2008, Jean Delvare wrote:
> > I think the only other blocking issue would be a way to configure
> > such new-style drivers from sysfs, primarily for one-off hardware
> > hacking usage (in at least this case).
> 
> This is the problem. Until there is a way to instantiate new-style
> drivers from user-space, we just can't remove the deprecated drivers.
> Even tagging it as deprecated is dishonest to some extent.

Not really; anyone who *can* use the newer stuff should do so.
If they can't, the older stuff is still there.


> So I see no 
> point in adding these drivers to the feature removal list for now. We
> can do that later, when we really offer an alternative with the same
> features.
> 
> You shouldn't fear that we forget to remove these drivers. They are the
> dust in my eye, I can't forget them.

OK.  :)

 
> >                                       Teaching the two new-style
> > drivers to use dynamic GPIO number allocation when there's no
> > platform_data is trivial,
> 
> Good to know...
> 
> >                           and not otherwise desirable.
> 
> I'm confused now.

The GPIOs can't really be used in-kernel without platform data.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
