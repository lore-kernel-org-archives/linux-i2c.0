From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] OF: add fsl,
	mcu-mpc8349emitx to the exception list
Date: Mon, 6 Oct 2008 11:31:58 -0600
Message-ID: <20081006173158.GA11208@secretlab.ca>
References: <20080923141219.GA31262@oksana.dev.rtsoft.ru>
	<20080930124424.GA6878@oksana.dev.rtsoft.ru>
	<20081001132248.191e92b3@hyperion.delvare>
	<20081001113948.GA20115@oksana.dev.rtsoft.ru>
	<20081006172831.GA27233@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20081006172831.GA27233-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 06, 2008 at 09:28:31PM +0400, Anton Vorontsov wrote:
> On Wed, Oct 01, 2008 at 03:39:48PM +0400, Anton Vorontsov wrote:
> [...]
> > > > Any issues with this or the second patch? Can we merge them?
> > > 
> > > I do not have the time to review these patches (and, honestly, have no
> > > interest in them.) So I will not merge them but I have no objection to
> > > them being merged by somebody else.
> > 
> > Ok, thanks for the sincerity.. ;-)
> > 
> > Kumar, could you pick up the two patches via the patchworks?
> > 
> > [1/2] OF: add fsl,mcu-mpc8349emitx to the exception list
> > http://patchwork.ozlabs.org/patch/1105/
> > 

Since I've been involved with the i2c of bindings, I can pick this one up.

> > [2/2] i2c: MPC8349E-mITX Power Management and GPIO expander driver
> > http://patchwork.ozlabs.org/patch/1106/

But I'm not involved enough with this one, so it should go through
kumar.

g.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
