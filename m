From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: sysfs - /sys/bus/i2c/devices is empty ?
Date: Mon, 22 May 2017 20:47:07 +0300
Message-ID: <CAHp75Vcvw74RjSt1VXPCOVS14P3dCX9HGdm7tPDfHQZdx9255Q@mail.gmail.com>
References: <E41D83B2B2E8CB42AC13E92B4C3FABD3B89353@TS-GGN-MBX002.ibtechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <E41D83B2B2E8CB42AC13E92B4C3FABD3B89353@TS-GGN-MBX002.ibtechnology.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Karthik BalaGuru T <karthik.t@incedoinc.com>
Cc: "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, May 20, 2017 at 11:26 AM, Karthik BalaGuru  T
<karthik.t@incedoinc.com> wrote:
> Hi ,
>
> The base kernel package(amd64 - 3.16-lts) that I brought up in intel atom=
 processor based board seems to not have the devices listed in /sys/bus/i2c=
/devices folder of sysfs. Can someone let me know what possible reason coul=
d be for the emptiness of the /sys/bus/i2c/devices folder ? What is the mis=
sing piece or step here that should be brought in for getting the devices l=
isted in /sys/bus/i2c/devices folder?
>
> Thanks in advance,
> Karthik Balaguru
> Disclaimer :
> This email communication may contain privileged and confidential informat=
ion and is intended for the use of the addressee only. If you are not an in=
tended recipient you are requested not to reproduce, copy disseminate or in=
 any manner distribute this email communication as the same is strictly pro=
hibited. If you have received this email in error, please notify the sender=
 immediately by return e-mail and delete the communication sent in error. E=
mail communications cannot be guaranteed to be secure & error free and Ince=
do Inc. is not liable for any errors in the email communication or for the =
proper, timely and complete transmission thereof.

You have to get rid of disclaimer first.


--=20
With Best Regards,
Andy Shevchenko
