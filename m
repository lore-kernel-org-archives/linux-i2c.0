From: Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Subject: RE: [PATCH 0/6] i2c-davinci gpio pulsed SCL recovery with ICPFUNC
Date: Wed, 20 Apr 2011 02:34:47 +0100
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE093FB40BBD@Cloud.RL.local>
References: <BANLkTinTMi76GmgO6HJ0+ifCXsHE3Mjsvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <BANLkTinTMi76GmgO6HJ0+ifCXsHE3Mjsvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Cc: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>, Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben Gardiner wrote:
> In "i2c-davinci: Fix race when setting up for TX" and "i2c-davinci:
> Fix TX setup for more SoCs" you mention testing on DM355 -- is there
> any you have hardware on which the recovery procedure is executed on
> occasion and that you would be available to test modifications to the
> current implementation?

Nope, sorry. I've never seen the bus lock up.

--
Jon Povey
jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
