From: Stephane Grosjean <s.grosjean-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>
Subject: Questions about i2c_transfer() usage in timer context...
Date: Mon, 20 Feb 2012 14:01:52 +0100
Message-ID: <4F424440.300@peak-system.com>
Reply-To: Stephane Grosjean <s.grosjean-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I'm facing a deadlock regarding a timer callback which is only calling=20
i2c_transfer(), and I wonder if this comes from that call: I first=20
googled and found that i2c_transfer() may sleep (which is forbidden in=20
my timer callback) but when I have a look the beginning of the function=
,=20
it starts to check if it is in any atomic context, before trying to=20
acquire  a lock...

So I'm afraid I'm lost and I hope someone will be able to understand to=
=20
that question: might i2c_transfer() be used in a timer callback or=20
should I handle my periodic call to i2c_tranfer() by means of a delayed=
=20
work?

Thanks for your reply,

Regards,

St=E9phane
