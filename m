From: "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
Date: Fri, 24 Jul 2009 09:34:13 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE40144FDB54B@dlee06.ent.ti.com>
References: <1247643267.5981.82.camel@localhost.localdomain>
	<4A5E0E98.2030108@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4A5E0E98.2030108-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Troy,
>
<Snip>

>I personally like the idea behind this patch. But I have
>heard others argue against it. But it is not related to the
>^C issue others have mentioned.That should not happen in
>the GIT kernel.
>
I do get this ^c timeout issue in DM6446 and DM355. I have the video loopba=
ck application running that uses tvp5146 to capture from a video source. Wh=
en I kill the application it starts giving the error while
the tvp5146 driver tries to send i2c commands to stop capture at tvp5146.
But in this case, it works again when the application is run again. But whe=
n I have mt9t031 connected and I do the same thing, it also fails with time=
out when application is killed. But it never recovers and I have to reboot =
the board to recover from the error. So what you mean by "That should not h=
appen in the GIT kernel" ?

Could you explain please?

Murali
