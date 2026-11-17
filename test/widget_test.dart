import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_pertemuan5/main.dart';

void main() {
  testWidgets('menampilkan ringkasan dan daftar tugas', (tester) async {
    await tester.pumpWidget(const TasklyApp());

    expect(find.text('Rencanakan harimu.'), findsOneWidget);
    expect(find.text('1/4 selesai'), findsOneWidget);
    expect(find.text('Review materi kuliah'), findsOneWidget);
  });

  testWidgets('dapat menambahkan tugas baru', (tester) async {
    await tester.pumpWidget(const TasklyApp());
    await tester.tap(find.text('Tugas baru'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(EditableText), 'Belajar Flutter');
    await tester.tap(find.text('Tambah'));
    await tester.pumpAndSettle();

    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('1/5 selesai'), findsOneWidget);
  });
}
