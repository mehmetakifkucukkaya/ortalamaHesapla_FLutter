import 'package:flutter/material.dart';
import 'package:ortalama_hesapla/constants/sabitler.dart';
import 'package:ortalama_hesapla/data/data.dart';
import 'package:ortalama_hesapla/widgets/ders_listesi.dart';

import '../models/ders.dart';
import 'ortalama_goster.dart';

class OrtalamaHesapla extends StatefulWidget {
  const OrtalamaHesapla({Key? key}) : super(key: key);

  @override
  State<OrtalamaHesapla> createState() => _OrtalamaHesaplaState();
}

class _OrtalamaHesaplaState extends State<OrtalamaHesapla> {
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = "";

  //* Formu kontrol etemek için key olışturuyoruz
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(Sabitler.baslikText, style: Sabitler.baslikStyle),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(
                    dersSayisi: Data.tumEklenenDersler.length,
                    ortalama: Data.ortalamaHesapla()),
              )
            ],
          ),
          Expanded(
            child: DersListesi(
              onElemanCikarildi: (index) {
                Data.tumEklenenDersler.removeAt(index);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatayPadding8,
            child: _buildTextFormField(),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: _buildHarfNotlari(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: _buildKrediler(),
                ),
              ),
              IconButton(
                onPressed: _dersEkleVeOrtalamaHesapla,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Sabitler.anaRenk,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.isEmpty) {
          return "Ders adini giriniz";
        } else {
          null;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Ders Adı Giriniz",
        border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  _buildHarfNotlari() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton<double>(
        value: secilenHarfDegeri,
        elevation: 16,
        onChanged: (deger) {
          setState(
            () {
              secilenHarfDegeri = deger!;
            },
          );
        },
        underline: Container(),
        items: Data.tumDerslerinHarfleri(),
      ),
    );
  }

  _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton<double>(
        value: secilenKrediDegeri,
        elevation: 16,
        onChanged: (deger) {
          setState(
            () {
              secilenKrediDegeri = deger!;
            },
          );
        },
        underline: Container(),
        items: Data.tumDerslerinKredileri(),
      ),
    );
  }

  _dersEkleVeOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);

      Data.dersEkle(eklenecekDers);

      setState(() {});
    }
  }
}
