From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] i2c: Push ioctl BKL down into the i2c code
Date: Fri, 23 May 2008 10:01:01 -0400
Message-ID: <9e4733910805230701w37900ebcrd8efabaee1c92331@mail.gmail.com>
References: <20080522222327.1af72794@core>
	 <20080523093545.175c769c@hyperion.delvare>
	 <20080523114639.1705de71@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756004AbYEWOBT@vger.kernel.org>
In-Reply-To: <20080523114639.1705de71@core>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 5/23/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Fri, 23 May 2008 09:35:45 +0200
>  Jean Delvare <khali@linux-fr.org> wrote:
>
>  > Hi Alan,
>  >
>  > On Thu, 22 May 2008 22:23:27 +0100, Alan Cox wrote:
>  > > Signed-off-by: Alan Cox <alan@redhat.com>
>  > >
>  >
>  > Description of what the patch does and why it is needed, please. I
>  > can't apply it without that. My first impression is a patch making the
>  > code bigger and more complex with no obvious benefit ;)


Alan, for people not familiar with the BKL attaching a write up or
pointer to the patches on the recommended ways to convert these locks
to something else would help. Some embedded developers won't know what
to do with these patches and they don't follow lkml.


> It pushes the BKL down into the i2c driver. The intention is to remove
>  the big kernel lock ioctl method from the file_operations structure so
>  that we can work on getting rid of the big kernel lock for good. It's one
>  of a series of patches that give me an x86-32 tree with no ->ioctl method
>  at all.
>
>  Similar activity is going on for the other calls made under the BKL the
>  goal being to push it down into drivers and then eliminate it.
>
>
>
>  _______________________________________________
>  i2c mailing list
>  i2c@lm-sensors.org
>  http://lists.lm-sensors.org/mailman/listinfo/i2c
>


-- 
Jon Smirl
jonsmirl@gmail.com
