From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Simultaneously access to one i2c/dev-interface from different
 process to different i2c devices
Date: Wed, 5 Nov 2014 02:19:53 -0800
Message-ID: <CAAVjN7cQ9AZJ-AkDhaW9zucHommSsW0VKL=b3=jctFr40dtOzQ@mail.gmail.com>
References: <5459E6C4.3060107@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5459E6C4.3060107-mnoMUKZXHfEb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Klein <matthias.klein-mnoMUKZXHfEb1SvskN2V4Q@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The kernel can handle the i2c-dev interface very well from multiple process.

When you open a file descriptor (/dev/i2c-x) a new client is created
on the i2c adapter corresponding to the id of the i2c dev just opened.
The client data is allocated into the file descriptor's private data.
each possess should open its own i2c dev fd for each adapter that
needs to be accessed. (the fd should also be closed within the i2c
process call wrapper you write). The kernel takes care of all locking
and the i2c-bus driver schedules the message ques. Just be shure to
open the i2c-dev with the non-blocking flag, to prevent locking out
your other threads/process from opening the device.

- Danielle

On Wed, Nov 5, 2014 at 12:58 AM, Matthias Klein
<matthias.klein-mnoMUKZXHfEb1SvskN2V4Q@public.gmane.org> wrote:
> Hello,
>
> is it possible from different processes to access different i2c devices on
> the same i2c bus/adapter using the i2c/dev-interface from userland?
>
> Or can the i2c/dev-interface only ne used from a single process?
>
>
> How does the simultaneously access to one adapter works for i2c device
> drivers inside the kernel?
> Do they fail on a simultaneously access, or do they wait until the i2c
> adapter is ready/free for use?
>
>
> Best regards,
> Matthias
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
- Danielle Costantino
