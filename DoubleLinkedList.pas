program Untitled;
uses crt;
const Max_Elemen=10;
type
    PData=^TData;
    TData=record
                info:integer;
                next:PData;
                prev:PData;
          end;
var
   head,tail,pilih: byte;
   awal,akhir : PData;
   menu,data  : integer;
//==============================================================================
procedure buat_list(var awal,akhir:PData);
begin
     awal:=nil;
     akhir:=nil;
end;
//==============================================================================
procedure init;
begin
  head:=0; tail:=0;
end;
//==============================================================================
function Kosong: boolean;
begin
     kosong:=(tail=0);
end;
//==============================================================================
function penuh: boolean;
begin
     penuh:=(tail=max_elemen);
end;
//==============================================================================
procedure sisip_depan(data:integer;var awal,akhir:PData);
var
   baru:PData;
begin
       new(baru);
       baru^.info := data;
       if (awal = nil) then
         akhir := baru
       else
       begin
         baru^.next := awal;
         awal^.prev := baru;
       end;
       awal := baru;
       akhir^.next := awal;
       awal^.prev := akhir;
end;
//==============================================================================
procedure sisip_belakang(data:integer;var awal,akhir:PData);
var
   baru:PData;
begin
     new(baru);
     baru^.info:=data;
     baru^.next:=nil;
     baru^.prev:=nil;
     if awal=nil then
     begin
          awal:=baru;
          akhir:=baru;
     end
     else
     begin
          akhir^.next:=baru;
          baru^.prev:=akhir;
          akhir:=baru;
     end;
     awal^.prev:=akhir;
     akhir^.next:=awal;
end;
//==============================================================================
procedure sisip_tengah(data:integer;var awal,akhir:PData);
var
   baru,bantu:PData;
   dicari:integer;
   ketemu:boolean;
   jawaban:string;
begin
     if (awal=nil) then
     begin
       writeln('   Data kosong, tidak bisa disisipkan');
       delay(2000);
       write('   Apakah data tetap dimasukkan[Y/N] ? ');readln(jawaban);
       if (jawaban='Y') or (jawaban='y') then
       begin
         sisip_depan(data,awal,akhir);
         writeln('   Data Berhasil Dimasukkan!');
         delay(2000);
       end
     end
     else
     if (awal=akhir) then
     begin
       writeln('   Data hanya ada 1, penyisipan dilakukan setelah data tersebut.');
       delay(2000);
       sisip_belakang(data,awal,akhir);
       writeln('   Data Berhasil Dimasukkan!');
       delay(2000);
     end
     else
     begin
       write('   Sisip setelah data apa ? ');readln(dicari);
       bantu:=awal;
       ketemu:=false;
          repeat
            if (bantu^.info=dicari) then
              ketemu:=true
            else
              bantu:=bantu^.next
          until (ketemu) or (bantu=akhir^.next);
          if (ketemu) then
          begin
            if (bantu=akhir) then
              sisip_belakang(data,awal,akhir)
            else
            begin
              new(baru);
              baru^.info:=data;
              baru^.next:=nil;
              baru^.prev:=nil;
              baru^.prev:=bantu;
              baru^.next:=bantu^.next;
              bantu^.next:=baru;
              bantu^.next^.prev:=baru;
            end;
            awal^.prev:=akhir;
            akhir^.next:=awal;
            writeln('   Data Berhasil Dimasukkan!');
            delay(2000);
          end
          else
            begin
            writeln('   Posisi sisip tidak ditemukan. Penyisipan dibatalkan');
            delay(2000);
            end;
    end;
end;
//==============================================================================
procedure hapus_depan(var data:Integer;var awal,akhir:PData);
var
   bantu:PData;
begin
     if awal=nil then
       writeln('   Data kosong. Perintah hapus dibatalkan')
     else
     if awal=akhir then
     begin
       data:=awal^.info;
       dispose(awal);
       awal:=nil;
       akhir:=nil;
     end
     else
     begin
       data:=awal^.info;
       bantu:=awal;
       akhir^.prev:=awal^.next;
       awal:=awal^.next;
       awal^.prev:=akhir;
       dispose(bantu);
     end;
end;
//==============================================================================
procedure hapus_belakang(var data:Integer;var awal,akhir:PData);
var
   bantu:PData;
begin
     if (awal=nil) or (awal=akhir) then
       hapus_depan(data,awal,akhir)
     else
     begin
       data:=akhir^.info;
       bantu:=akhir;
       akhir^.prev^.next:=awal;
       awal^.prev:=akhir^.prev;
       akhir:=akhir^.prev;
       dispose(bantu);
     end;
end;
//==============================================================================
procedure hapus_tengah(var data:Integer;var awal,akhir:PData);
var
   bantu:PData;
   posisihapus,posisi:integer;
   ketemu:boolean;
begin
     if (awal=nil) then
       hapus_depan(data,awal,akhir)
     else
     if (awal=akhir) then
     begin
       writeln('   Data hanya ada 1, penghapusan dilakukan pada data tersebut.');
       delay(2000);
       hapus_depan(data,awal,akhir);
     end
     else
     begin
       write('Hapus Data Yang ke-?');readln(posisihapus);
       if (awal = akhir) or (posisihapus = 1) then
         hapus_depan(data,awal,akhir)
       else
       begin
         bantu:=awal^.next;
         ketemu:=false;
         posisi:=2;
         while (not ketemu) and (bantu <> akhir^.next) do
         begin
           if (posisi = posisihapus) then
             ketemu:=true
           else
           begin
             bantu:=bantu^.next;
             posisi:=posisi+1;
           end;
         end;
         if (not ketemu) then
           writeln('   Posisi sisip tidak ditemukan. Penghapusan dibatalkan')
         else
         if (bantu = akhir) then
           hapus_belakang(data,awal,akhir)
         else
         begin
           bantu^.prev^.next:=bantu^.next;
           bantu^.next^.prev:=bantu^.prev;
           dispose(bantu);
         end;
       end;
     end;
end;
//==============================================================================
procedure enqueue;
begin
  if not penuh then
  begin
    if kosong then
    begin
      head:=1; tail:=1;
      sisip_depan(data,awal,akhir);
    end
    else
    begin
      inc(tail);
      sisip_belakang(data,awal,akhir);
    end;
  end;
end;
//==============================================================================
procedure tampil_data(awal,akhir:PData);
var
   bantu:PData;
begin
  if (awal=nil) then
    writeln('   Data kosong')
  else
  if (awal=akhir) then
    writeln('   Data  : ', awal^.info)
  else
  begin
    write('   Data  : ');
    bantu:=awal;

    repeat
      write(bantu^.info:6);
      bantu:=bantu^.next;
    until bantu=akhir^.next;

    writeln;
  end;
end;
//==============================================================================                                                                                
begin
  buat_list(awal,akhir);

  repeat
  writeln('    +--------------------------+');
  writeln('    ¦       MENU PILIHAN       ¦');
  writeln('    ¦--------------------------¦');
  writeln('    ¦ 1.¦ Tambah Depan         ¦');
  writeln('    ¦ 2.¦ Tambah Tengah        ¦');
  writeln('    ¦ 3.¦ Tambah Belakang      ¦');
  writeln('    ¦ 4.¦ Hapus Depan          ¦');
  writeln('    ¦ 5.¦ Hapus Tengah         ¦');
  writeln('    ¦ 6.¦ Hapus Belakang       ¦');
  writeln('    ¦ 7.¦ Tambah (Queue)       ¦');
  writeln('    ¦ 8.¦ Ambil Data (Queue)   ¦');
  writeln('    ¦ 9.¦ Tambah (Stack)       ¦');
  writeln('    ¦10.¦ Ambil Data (Stack)   ¦');
  writeln('    ¦11.¦ Tampilkan Data       ¦');
  writeln('    ¦ 0.¦ Keluar               ¦');
  writeln('    +--------------------------+');
  write('   Masukkan menu pilihan anda : ');readln(menu);

  case menu of
     1: begin
          write('Masukkan Data : ');readln(data);
          sisip_depan(data,awal,akhir);
          writeln('Data Berhasil Dimasukkan!');
          delay(2000);
     end;
     2: begin
          write('Masukkan Data : ');readln(data);
          sisip_tengah(data,awal,akhir);
     end;
     3: begin
          write('Masukkan Data : ');readln(data);
          sisip_belakang(data,awal,akhir);
          writeln('Data Berhasil Dimasukkan!');
          delay(2000);
     end;
     4: begin
          hapus_depan(data,awal,akhir);
     end;
     5: begin
          hapus_tengah(data,awal,akhir);
     end;
     6: begin
          hapus_belakang(data,awal,akhir);
     end;
     7: begin
          write('Masukkan Data : ');readln(data);
          enqueue;
          writeln('Data Berhasil Dimasukkan!');
          delay(2000);
     end;
     11: begin
          tampil_data(awal,akhir);
     end;
     0: begin

     end;
     end;
     until menu=0;

     writeln('Program selesai');
     readln;
end.
