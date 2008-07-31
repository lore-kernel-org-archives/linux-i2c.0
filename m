From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
	configurable via FDT
Date: Thu, 31 Jul 2008 13:35:58 -0400
Message-ID: <9e4733910807311035o4b95b83ficed437d463f2ad37@mail.gmail.com>
References: <488982B5.4070102@grandegger.com> <48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4891F4D8.9090905-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
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
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 7/31/08, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
> Jon Smirl wrote:
> > There appears to be one for i2x8xxx but not the other CPUs.
> >
> > /* I2C
> > */
> > typedef struct i2c {
> >        u_char  i2c_i2mod;
> >        char    res1[3];
> >        u_char  i2c_i2add;
> >        char    res2[3];
> >        u_char  i2c_i2brg;
> >        char    res3[3];
> >        u_char  i2c_i2com;
> >        char    res4[3];
> >        u_char  i2c_i2cer;
> >        char    res5[3];
> >        u_char  i2c_i2cmr;
> >        char    res6[0x8b];
> > } i2c8xx_t;
> >
>
>  The I2C interface for the MPC5200 is not compatible with the one for the
> MPC83/4/5/6xx, AFAIK.

Ignore that table, I mistook MPC8xx for MPC8xxx. That is a MPC8xx table.

>
>  Wolfgang.
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
